resource "aws_launch_template" "this" {
  name_prefix   = "${var.project_id}-template"
  image_id      = var.ami_id
  instance_type = "t3.micro"

  key_name = var.ssh_key_name

  iam_instance_profile {
    name = "${var.project_id}-instance_profile"
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups = [
      var.ec2_sg_id,
      var.http_sg_id
    ]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd aws-cli jq
    systemctl enable httpd
    systemctl start httpd

    TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id)
    PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4)

    echo "This message was generated on instance $INSTANCE_ID with the following IP: $PRIVATE_IP" > /var/www/html/index.html

    aws s3 cp /var/www/html/index.html s3://${var.project_id}-bucket/$INSTANCE_ID.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Terraform = "true"
      Project   = var.project_id
    }
  }

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.project_id}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Terraform = "true"
    Project   = var.project_id
  }
}

resource "aws_lb" "this" {
  name               = "${var.project_id}-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.public_subnets

  tags = {
    Terraform = "true"
    Project   = var.project_id
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

resource "aws_autoscaling_group" "this" {
  name                = "${var.project_id}-asg"
  max_size            = 2
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = var.private_subnets

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.this.arn]

  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
}