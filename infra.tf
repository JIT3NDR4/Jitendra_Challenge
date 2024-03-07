provider "aws" {
    region = "us-east-1"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "ami_id" {
  default = "ami-07761f3ae34c4478d"
}

variable "security_group_name" {
  default = "my_new_web_sg"
}

variable "ssh_port" {
  default = 22
}

variable "http_port" {
  default = 80
}

variable "https_port" {
  default = 443
}

variable "key_pair" {
  default = "webkey"
}

# Creating security group
resource "aws_security_group" "my_web_sg" {
  name        = var.security_group_name
  description = "Allow SSH, HTTP, and HTTPS inbound traffic"

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
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

# Creating EC2 instance
resource "aws_instance" "my_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_pair
  security_groups = [aws_security_group.my_web_sg.name]

  tags = {
    Name = "My Web Server"
  }

}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.my_server.public_ip
}