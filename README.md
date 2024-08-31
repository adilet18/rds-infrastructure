EC2 and RDS Instances Inside a Custom VPC on AWS


| Name | Version |
|------|---------|
| [aws](#provider_aws) | AWS region to deploy resources |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.mysql_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_eip.web_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.web_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.my_key_pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_route_table.private_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.db_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.web_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ssm_parameter.rds_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_subnet.private_subnet_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [local_file.private_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_string.rds_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tls_private_key.my_key_pair](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.latest_ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_ssm_parameter.my_rds_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [aws_region](#input_aws_region) | AWS region to deploy resources | `string` | `"us-east-1"` | no |
| [env](#input_env) | AWS region to deploy resources | `string` | `"dev"` | no |
| [my_ip](#input_my_ip) | AWS region to deploy resources | `string` | `"109.201.189.68"` | no |
| [private_subnet_cidrs_db](#input_private_subnet_cidrs_db) | AWS region to deploy resources | `list(string)` | <pre>[<br>  "10.0.101.0/24",<br>  "10.0.102.0/24"<br>]</pre> | no |
| [public_subnet_cidrs](#input_public_subnet_cidrs) | AWS region to deploy resources | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| [settings](#input_settings) | Settings for Database instance | `map(any)` | <pre>{<br>  "database": {<br>    "allocated_storage": 30,<br>    "db_name": "mydb",<br>    "engine": "mysql",<br>    "engine_version": "5.7",<br>    "identifier": "rds-mysql",<br>    "instance_class": "db.t3.micro",<br>    "username": "administrator"<br>  },<br>  "instance": {<br>    "count": 1,<br>    "instance_type": "t3.micro"<br>  }<br>}</pre> | no |
| [vpc_cidr](#input_vpc_cidr) | AWS region to deploy resources | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| [database_endpoint](database_endpoint) | AWS region to deploy resources |
| [database_port](database_port) | AWS region to deploy resources |
| [private_key_pem](private_key_pem) | AWS region to deploy resources |
| [web_public_dns](web_public_dns) | AWS region to deploy resources |
| [web_public_ip](web_public_ip) | AWS region to deploy resources |
