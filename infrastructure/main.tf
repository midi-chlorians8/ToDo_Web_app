provider "aws" {
  region = var.region
  #version = "3.27.0"
}



data "aws_ami" "ubuntu" {
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  most_recent = true

  owners = ["099720109477"] # Canonical
}


variable "key_name" {
  default = "KeyFromLinuxAWS-Frankfurt"
}

resource "aws_security_group" "example" {
  name        = "todo_terraform_sg"
  description = "Allow SSH and HTTP/HTTPS traffic"

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  
}

resource "aws_instance" "my_serv90" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name      = var.key_name
  security_groups = [aws_security_group.example.name]

  user_data = "${file("install_awscli_docker.sh")}"

  tags = {
    Name = "ToDoFastApi_CheapWorker"
    terraform = true
    proj = "ToDoFastApi"
  }
}

resource "aws_eip" "example" {
  vpc = true
}

output "public_ip" {
  description = "Contains the public IP address"
  value       = aws_eip.example.public_ip
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = aws_instance.my_serv90.id
  allocation_id         = aws_eip.example.id
}





