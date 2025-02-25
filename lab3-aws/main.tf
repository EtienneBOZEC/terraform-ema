resource "aws_instance" "etienne-t3" {
  ami           = "ami-0446057e5961dfab6"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.etienne.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_etienne.id]
  subnet_id = "subnet-0d4c3122cb0327eb2"

  tags = {
    Name = "etienne-t3"
  }
}

resource "aws_security_group" "allow_ssh_etienne" {
  vpc_id = "vpc-04e7fa58d477c06b7"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Modifiez pour restreindre l'accès si nécessaire
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
  public_key = file("~/.ssh/id_ed25519.pub")  # Path to your public SSH key
}