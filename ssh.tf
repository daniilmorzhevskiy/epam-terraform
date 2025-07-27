resource "aws_key_pair" "cmtr_keypair" {
  key_name   = "cmtr-dmg42ceb-keypair"
  public_key = var.ssh_key

  tags = {
    Project = "epam-tf-lab"
    ID      = "cmtr-dmg42ceb"
  }
}