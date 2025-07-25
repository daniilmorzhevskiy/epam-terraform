aws_access_key = "AKIA2HVQ5E6XVK3X46QA"
aws_secret_key = "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"

vpc_cidr = "10.10.0.0/16"

public_subnets = {
  a = { cidr_block = "10.10.1.0/24", az = "us-east-1a" }
  b = { cidr_block = "10.10.3.0/24", az = "us-east-1b" }
  c = { cidr_block = "10.10.5.0/24", az = "us-east-1c" }
}
