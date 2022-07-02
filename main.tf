provider "aws" {
  region = "ap-northeast-1"
}

variable "example_instance_type" {
  default = "t3.micro"
}

resource "aws_instance" "example" {
  ami           = "ami-0b7546e839d7ace12"
  instance_type = var.example_instance_type

  tags = {
    Name = "example"
  }

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}
