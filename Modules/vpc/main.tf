# create a Vpc
resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}
 


 #create an internet gateway to the vpc
 resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-igw"

  }
}


# use datasource to get all availability zones
# Declare the data source

data "aws_availability_zones" "available" {
  state = "available"
}


#create public subnet az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_az1_cidr

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project_name}-public-subnet-az1"
  }
}

# create public subnet az2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_az2_cidr

  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.project_name}-public-subnet-az2"
  }
}

# create route tables and public routes
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.project_name}-public-route-table"
  }
}

# associate public subnets az1 to route table
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}


# associate public subnets az1 to route table
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}


# create private app subnet az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_app_subnet_az1_cidr
  map_public_ip_on_launch = false

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project_name}-private_app-subnet-az1"
  }
}


#create private-app subnet az2
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_app_subnet_az2_cidr
  map_public_ip_on_launch = false

  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.project_name}-private_app-subnet-az2"
  }
}

#create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_data_subnet_az1_cidr
  map_public_ip_on_launch = false

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project_name}-private_data-subnet-az1"
  }
}

#create private data subnet az2
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.private_data_subnet_az2_cidr
  map_public_ip_on_launch = false

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.project_name}-private_data-subnet-az2"
  }
}

