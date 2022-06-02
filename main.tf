terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"

    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "terraform_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "terraform vpc"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = var.private_subnets
  availability_zone = "us-east-1a"

  tags = {
    Name = "private subnet"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "public subnet 2"
  }
}

resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id
  
  tags = {
    Name = "terraform internet gateway"
  }
}

resource "aws_db_instance" "terraform_mysql" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

terraform {
  backend "s3" {
    bucket         = "terra4ormbuck3t"
    key            = "terraform.tfstate"
    region         = var.region
    dynamodb_table = "terraform_mysql"
  }
}

resource "aws_lb" "terraform_lb" {
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  enable_deletion_protection = false

  tags = {
    Name = "terraform_lb"
  }
}
