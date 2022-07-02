provider "aws" {
  region = "ap-northeast-1"
}

variable "instance_type" {
}

resource "aws_security_group" "default" {
  name = "ec2"

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
}

resource "aws_instance" "default" {
  ami                    = "ami-0b7546e839d7ace12"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "terraform-httpd-sample"
  }

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}

output "public_dns" {
  value = aws_instance.default.public_dns
}
