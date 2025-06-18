provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "networking" {
  source              = "../../modules/networking"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                 = ["us-east-1a", "us-east-1b"]
  name_prefix         = "pokernowai"
}

module "iam" {
  source      = "../../modules/iam"
  name_prefix = "pokernowai"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "pokernowai-eks"
  cluster_version = "1.29"
  vpc_id          = module.networking.vpc_id
  subnet_ids      = module.networking.private_subnet_ids

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