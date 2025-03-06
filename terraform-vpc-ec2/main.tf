terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${local.workspace_name}-vpc"
  }
}

resource "aws_security_group" "allow_ssh_http" {
  vpc_id = aws_vpc.main.id
  name   = "allow_ssh_http"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "${local.workspace_name}-sg"
  }
}

resource "aws_instance" "web" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.allow_ssh_http.name]

  tags = {
    Name = "${local.workspace_name}-instance"
  }
}
