provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source                = "../../modules/networking"
  vpc_cidr              = "10.123.0.0/16"
  public_subnet_cidrs   = ["10.123.1.0/24", "10.123.2.0/24"]
  private_subnet_cidrs  = ["10.123.3.0/24", "10.123.4.0/24"]
  intra_subnet_cidrs    = ["10.123.5.0/24", "10.123.6.0/24"]
  azs                   = ["us-east-1a", "us-east-1b"]
  name_prefix           = "pokernowai"
  region                = "us-east-1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "pokernowai-eks"
  cluster_version = "1.32"
  vpc_id          = module.networking.vpc_id
  subnet_ids      = module.networking.private_subnet_ids
  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    default = {
      name           = "default"
      instance_types = ["t3.small"]
      desired_size   = 2
      min_size       = 2
      max_size       = 2
    }
  }
}

module "ecr" {
  source      = "../../modules/ecr"
  name_prefix = "pokernowai"
}