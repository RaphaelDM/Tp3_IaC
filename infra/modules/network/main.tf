terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
// Module pour la création du réseau (VPC, subnets, IGW, route tables)
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(var.tags, {
    Name = "vpc-${var.environment}"
  })
}

// Subnet public pour les ressources accessibles depuis Internet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true #tfsec:ignore:aws-ec2-no-public-ip-subnet

  tags = merge(var.tags, {
    Name = "subnet-public-${var.environment}"
  })
}

// Subnet privé pour les ressources non accessibles depuis Internet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = merge(var.tags, {
    Name = "subnet-private-${var.environment}"
  })
}

// Internet Gateway pour permettre l'accès à Internet depuis le subnet public
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "igw-${var.environment}"
  })
}

// Route table pour le subnet public, avec une route vers l'Internet Gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.tags, {
    Name = "rt-public-${var.environment}"
  })
}
// Association de la route table publique au subnet public
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}