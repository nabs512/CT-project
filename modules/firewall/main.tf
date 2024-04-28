resource "aws_security_group" "rds_sg" {
  name = "rds-sg"
  description = "Security Group for RDS Database"

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]  # Allow access from VPC only (modify as needed)
  }

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol = "tcp"
    cidr_blocks = [aws_security_group.web_server_sg]  # Allow access from EC2 instances security group
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic (adjust as needed)
  }

  tags = {
    Name = "RDS-Security-Group"
  }
}

resource "aws_security_group" "web_server_sg" {
  name = "web-server-sg"
  description = "Security Group for Web Server Instances"

  ingress {
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # Replace with specific IP
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from anywhere (adjust as needed)
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic (adjust as needed)
  }

  tags = {
    Name = "Web-Server-Security-Group"
  } 
}
resource "aws_security_group" "web_server_sg_2" {
  name = "web-server-sg-2"
  description = "Security Group for Web Server Instances"

  ingress {
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "Web-Server-Security-Group-2"
  }
}