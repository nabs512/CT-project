provider "aws" {
  region = "us-east-1" 
}

# Calling VPC Module
module "vpc" {
  source  = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

# Calling the RDS Module with VPC outputs
module "rds" {
  source  = "./modules/rds"
  vpc_id  = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  # Additional RDS configuration parameters
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = "db.t2.micro"
  allocated_storage  = 20
  multi_az           = true
}

# Calling the  EC2 Module with VPC outputs and RDS Security Group
module "ec2" {
  source  = "./modules/ec2"
  vpc_id  = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_ids[0]
  rds_security_group_id = module.rds.security_group_id

  # Additional EC2 configuration parameters
  ami           = "ami-0123456789abcdef0" # Replace with your required AMI 
  instance_type = "t2.micro"
}

# Call the ELB Module with VPC outputs and EC2 Instance ID
module "elb" {
  source  = "./modules/elb"
  vpc_id  = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
  security_groups = [aws_security_group.web_server_sg.id]
  instance_id = module.ec2.instance_id

  # Additional ELB configuration parameters
  internal                  = false # Set to true for internal ELB
  health_check_type       = "HTTP"
  cross_zone             = true
}

# Call Autoscaling Module with VPC outputs and Launch Configuration
module "autoscaling" {
  source  = "./modules/autoscaling"
  vpc_id  = module.vpc.vpc_id
  launch_configuration_name = module.ec2.launch_configuration.name

  #Autoscaling configuration parameters
  min_size               = 1
  max_size               = 2
  desired_capacity       = 1
}

# Security Group for Web Server (defined outside for ELB access)
resource "aws_security_group" "web_server_sg" {
  name = "web-server-sg"
  description = "Security Group for Web Server Instances"

  # Security group rules for web server access
  ingress {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = [module.vpc.public_subnet_cidr_blocks[0]]
  }

  # Additional security group rules for web server access as needed
}


