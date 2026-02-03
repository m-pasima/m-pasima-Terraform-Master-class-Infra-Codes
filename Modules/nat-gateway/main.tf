# Elastic IP for nat-gateway AZ1
resource "aws_eip" "eip_for_nat_gateway_az1" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip-az1"
  }
}

# Elastic IP for nat-gateway AZ2
resource "aws_eip" "eip_for_nat_gateway_az2" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip-az2"
  }
}

#Create Nat-gateway for public subnet az1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip_for_nat_gateway_az1.id
  subnet_id     = var.public_subnet_az1_id  

  tags = {
    Name = "${var.project_name}-nat-gateway-az1"
  }

  #  Use depends_on - reference the variable
  depends_on = [var.internet_gateway_id]
}

# Create Nat-gateway for public subnet az2
resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.eip_for_nat_gateway_az2.id
  subnet_id     = var.public_subnet_az2_id  

  tags = {
    Name = "${var.project_name}-nat-gateway-az2"
  }

 
  depends_on = [var.internet_gateway_id]
}
