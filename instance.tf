#---------------------------------------------------------------------
#                         SSH Key Pair
#---------------------------------------------------------------------

resource "tls_private_key" "my_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-ec2-key"
  public_key = tls_private_key.my_key_pair.public_key_openssh
}

resource "local_file" "private_key_pem" {
  filename        = "./my-ec2-key.pem"
  content         = tls_private_key.my_key_pair.private_key_pem
  file_permission = "0400"
}



data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "web_server" {
  count                  = var.settings.instance.count
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.settings.instance.instance_type
  subnet_id              = aws_subnet.public_subnet[count.index].id
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "${var.env}-web-instance-${count.index + 1}"
  }
}

resource "aws_eip" "web_eip" {
  count    = var.settings.instance.count
  instance = aws_instance.web_server[count.index].id
  domain   = "vpc"
  tags = {
    Name = "web-eip-${count.index + 1}"
  }
}
