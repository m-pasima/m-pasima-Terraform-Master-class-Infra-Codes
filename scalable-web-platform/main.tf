provider "aws" {
  region = var.region
}


# create VPC (REFERENCE TO THE VPC MODULE
module "vpc" {
  source = "../Modules/vpc"

  vpc_cidr                     = var.vpc_cidr
  project_name                 = var.project_name
  region                       = var.region
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr

}




# Create NAT-GATEWAY (REFERENCE TO THE NAT GATEWAY MODULE)
module "nat_gateway" {
   source = "../Modules/nat-gateway"

   project_name         = var.project_name
   public_subnet_az1_id = module.vpc.public_subnet_az1_id
   public_subnet_az2_id = module.vpc.public_subnet_az2_id
   internet_gateway_id  = module.vpc.internet_gateway_id
}

#  create security group (REFERENCE THE SECURITY GROUP MODULE)

module "security_group"{
  source = "../Modules/security-groups"

  project_name = var.project_name
  vpc_cidr = module.vpc.vpc_cidr
}