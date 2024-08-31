#------------------------------------------------------------
# Generating Passwords and Storing them into ParameterStore
#------------------------------------------------------------


resource "random_string" "rds_password" {
  length           = 11
  special          = true
  override_special = "*$%&"
}


resource "aws_ssm_parameter" "rds_password" {
  name        = "/prod/mysql"
  description = "Password for MySQL"
  type        = "SecureString"
  value       = random_string.rds_password.result
}


data "aws_ssm_parameter" "my_rds_password" {
  name       = "/prod/mysql"
  depends_on = [aws_ssm_parameter.rds_password]
}

#-------------------------------------------------------------------
#                    Creating RDS Database
#-------------------------------------------------------------------

resource "aws_db_instance" "mysql_db" {
  identifier             = var.settings.database.identifier
  db_name                = var.settings.database.db_name
  allocated_storage      = var.settings.database.allocated_storage
  engine                 = var.settings.database.engine
  engine_version         = var.settings.database.engine_version
  instance_class         = var.settings.database.instance_class
  username               = var.settings.database.username
  password               = data.aws_ssm_parameter.my_rds_password.value
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  apply_immediately      = true
  tags = {
    Name = "${var.env}-${var.settings.database.identifier}"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "main_subnet_group"
  description = "The main group of subnets"
  subnet_ids  = [for subnet in aws_subnet.private_subnet_db : subnet.id]
}
