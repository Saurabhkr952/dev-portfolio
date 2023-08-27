module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  cluster_name    = "myapp-eks-cluster"
  cluster_version = "1.26"

  subnet_ids = module.myapp-vpc.private_subnets
  vpc_id = module.myapp-vpc.vpc_id 
  
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  enable_irsa = true


  tags = {
    environment = "dev"
    application = "myapp"
  }

# EKS Managed Node Group(s
  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.xlarge"]
      capacity_type  = "SPOT"
    }
  }


}
