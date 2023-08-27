variable "vpc_cidr_block" {}
variable "availability_zone" {}
variable "vpc_public_subnet_cidr_block" {}
variable "vpc_private_subnet_cidr_block" {}


module "myapp-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  

  name = "myapp-vpc"
  cidr = var.vpc_cidr_block

  azs             = var.availability_zone
  private_subnets = var.vpc_private_subnet_cidr_block
  public_subnets  = var.vpc_public_subnet_cidr_block

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  
tags = {
  "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
}
public_subnet_tags = {
  "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
  "kubernetes.io/role/elb" = 1
}
private_subnet_tags = {
  "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
  "kubernetes.io/role/internal-elb" = 1
}
}