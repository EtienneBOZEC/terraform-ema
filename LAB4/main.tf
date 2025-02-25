terraform {
  backend "s3" {
    bucket         = "terraform-state-qh2o7"
    key            = "global/s3/student_12/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

variable "min_size" {}
variable "max_size" {}

resource "aws_launch_template" "etienne_lt" {
  name_prefix   = "etienne-lt-"
  image_id      = "ami-0446057e5961dfab6"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.etienne.key_name

  network_interfaces {
    security_groups = [aws_security_group.allow_ssh_etienne.id]
    subnet_id       = "subnet-0d4c3122cb0327eb2"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "etienne-asg"
    }
  }
}

resource "aws_autoscaling_group" "etienne_asg" {
  desired_capacity     = var.min_size
  min_size            = var.min_size
  max_size            = var.max_size
  vpc_zone_identifier = ["subnet-0d4c3122cb0327eb2"]

  launch_template {
    id      = aws_launch_template.etienne_lt.id
    version = "$Latest"
  }
}

resource "aws_security_group" "allow_ssh_etienne" {
  vpc_id = "vpc-04e7fa58d477c06b7"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowSSH-etienne"
  }
}

resource "aws_key_pair" "etienne" {
  key_name   = "etienne-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}
