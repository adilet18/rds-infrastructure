#---------------------------------------------------------------------
#                   MySQL Database Security Group
#---------------------------------------------------------------------

resource "aws_security_group" "db_security_group" {
  name        = "main-rds-sg"
  description = "Securtiy Group for Database"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow MySQL traffic from only the web sg"
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.env}-${var.settings.database.identifier}"
  }
}

#---------------------------------------------------------------------
#                       Web Securiy Group
#---------------------------------------------------------------------

resource "aws_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Security Group for Web Servers"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow all traffic through HTTP"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from my computer"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-sg"
  }
}
