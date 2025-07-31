resource "aws_launch_template" "this" {
  name          = "cmtr-dmg42ceb-template"
  image_id      = "ami-09e6f87a47903347c"
  instance_type = "t3.micro"
  key_name      = var.ssh_key_name

  iam_instance_profile {
    name = "cmtr-dmg42ceb-instance_profile"
  }

  network_interfaces {
    security_groups       = [var.ec2_sg_id, var.http_sg_id]
    delete_on_termination = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = base64encode(templatefile("${path.module}/startup.sh", {}))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name     = "cmtr-dmg42ceb-instance"
      Terraform = "true"
      Project   = "cmtr-dmg42ceb"
    }
  }
}

resource "aws_autoscaling_group" "this" {
  name                      = "cmtr-dmg42ceb-asg"
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 2
  vpc_zone_identifier       = var.private_subnet_ids
  health_check_type         = "EC2"
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [target_group_arns, load_balancers]
  }

  tag {
    key                 = "Project"
    value               = "cmtr-dmg42ceb"
    propagate_at_launch = true
  }

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }
}

resource "aws_lb" "this" {
  name               = "cmtr-dmg42ceb-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Project   = "cmtr-dmg42ceb"
    Terraform = "true"
  }
}

resource "aws_lb_target_group" "this" {
  name     = "cmtr-dmg42ceb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Project   = "cmtr-dmg42ceb"
    Terraform = "true"
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = aws_autoscaling_group.this.name
  lb_target_group_arn    = aws_lb_target_group.this.arn
}