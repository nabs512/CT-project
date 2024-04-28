
resource "aws_instance" "web_server" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = {
    Name = "Web-Server"
  }

}

resource "aws_launch_configuration" "web_server_config" {
  name          = "web-server-config"
  image_id       = var.ami
  instance_type = var.instance_type

  # Security Groups
  security_groups = [aws_security_group.web_server_sg.id, var.rds_security_group_id]

}

output "instance_id" {
  value = aws_instance.web_server.id
}



resource "aws_instance" "web_server_2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = {
    Name = "Web-Server_2"
  }

}

resource "aws_launch_configuration" "web_server_config_2" {
  name          = "web-server-config"
  image_id       = var.ami
  instance_type = var.instance_type

  # Security Groups
  security_groups = [aws_security_group.web_server_2_sg.id, var.rds_security_group_id]

}

output "instance_id" {
  value = aws_instance.web_server_2.id
}
