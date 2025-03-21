# Configure the terraform AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a new VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.4.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc" # Change this to your unique name
  }
}

# Create a new subnet
resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  # A /27 CIDR block provides 30 IP Addresses
  cidr_block        = "10.0.4.0/27"
  availability_zone = "us-east-1a"

  # Ensure instances get a public IP
  map_public_ip_on_launch = true

  tags = {
    Name = "my-subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Create a Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "my-route-table"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "my_route_table_assoc" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

# Create Security Group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# Launch EC2 Instance with Apache
resource "aws_instance" "web_server" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  instance_type          = "t2.micro"              # Free-tier instance
  subnet_id              = aws_subnet.my_subnet.id # Launch in the new subnet
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # User Data Script to Install Apache
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello from $(hostname -f)</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Apache-Web-Server"
  }
}

# Output the Public IP Address of the Web Server
output "public_ip" {
  value = aws_instance.web_server.public_ip
}

# Output HTTP url to access the web server
output "server_home_page" {
  value = "http://${aws_instance.web_server.public_ip}/"
}
