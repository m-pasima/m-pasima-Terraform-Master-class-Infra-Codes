# FIX 1: Keep existing variable outputs
output "vpc_cdr" {
    value = var.vpc_cidr
}

output "project_name" {
    value = var.project_name
}

output "region" {
    value = var.region
}

output "public_subnet_az1_cdr" {
    value = var.public_subnet_az1_cidr
}

output "public_subnet_az2_cdr" {
    value = var.public_subnet_az2_cidr
}

output "private_app_subnet_az1_cdr" {
    value = var.private_app_subnet_az1_cidr
}

output "private_app_subnet_az2_cdr" {
    value = var.private_app_subnet_az2_cidr
}

output "private_data_subnet_az1_cdr" {
    value = var.private_data_subnet_az1_cidr
}

output "private_data_subnet_az2_cdr" {
    value = var.private_data_subnet_az2_cidr
}

# FIX 1: ADD MISSING RESOURCE ID OUTPUTS - These were missing and causing "Unsupported attribute" errors
output "public_subnet_az1_id" {
  description = "ID of public subnet in AZ1"
  value = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
  description = "ID of public subnet in AZ2"
  value = aws_subnet.public_subnet_az2.id
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value = aws_internet_gateway.internet_gateway.id
}