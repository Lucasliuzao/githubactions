provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_vpc"
    }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "main_subnet"
    }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block = "0.0.0.0./0"
    gateway_id = aws_internet_gateway.main.id 
    }
    tags = {
      Name = "main_route_table"
    }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "web-sg" {
    name        = "web-server-sg"
    description = "Allow HTTP and SSH traffic"
    vpc_id      = aws_vpc.main.id
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }

    ingress {
        from_port   = 8081
        to_port     = 8081
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }

    tags = {
        Name = "web-server-sg"
    }
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (HVM), SSD Volume Type - us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.web-sg.id]

  password_data = var.admin_password

  tags = {
    Name = "VM-GithubActions-AWS"
    }
}