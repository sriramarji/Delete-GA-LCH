resource "aws_instance" "web" {
  ami                    = var.ami_id #variabilise values 
  instance_type          = var.inst_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.inst_sg.id]   # to launch instance under part SG

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    curl -fsSL https://get.docker.com -o install-docker.sh
    sudo sh install-docker.sh
    sudo usermod -aG docker ubuntu
    docker run -d -p 80:80 \
     -e OPENPROJECT_SECRET_KEY_BASE=secret \
     -e OPENPROJECT_HTTPS=false \
     apache/devlake
  EOF

  tags = {
    Name = "Docker"
  }
}

resource "aws_security_group" "inst_sg" {

  name   = "ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
}