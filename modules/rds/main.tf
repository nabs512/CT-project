

resource "aws_db_instance" "rds" {
  allocated_storage  = var.allocated_storage
  engine             = var.engine
  engine_version     = var.engine_version
  instance_class     = var.instance_class
  multi_az           = var.multi_az
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "WordPress-DB"
  }
}

resource "aws_db_subnet_group" "default" {
  name = "wordpress-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "WordPress-DB-Subnet-Group"
  }
}

resource "aws_security_group" "rds_sg" {
  name = "rds-sg"
  description = "Security Group for RDS Database"

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol = "tcp"
    cidr_blocks = [aws_subnet_public_subnet.cidr_block] # Allowing access from public subnet for initial setup 
  }
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol = "tcp"
    cidr_blocks = [aws_subnet_private_subnet.cidr_block] # Allowing access from private subnet only
}
  egress {
    from_port = 3306
    to_port = 80
    protocol = "http"
    cidr_blocks = [aws_subnet_public_subnet.cidr_block]
 }
}

output "security_group_id" {
  value = aws_security_group.rds_sg.id
}
