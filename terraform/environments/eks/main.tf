provider "aws" {
  region = "us-east-1"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
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
  source       = "../../modules/iam"
  name_prefix  = "pokernowai"
}

module "eks" {
  source               = "../../modules/eks"
  cluster_name         = "pokernowai-eks"
  vpc_id               = module.networking.vpc_id
  private_subnet_ids   = module.networking.private_subnet_ids
  cluster_role_arn     = module.iam.eks_cluster_role_arn
  node_role_arn        = module.iam.eks_node_role_arn
}

module "ecr" {
  source       = "../../modules/ecr"
  name_prefix  = "pokernowai"
}

module "istio" {
  source = "../../modules/istio"
}

module "app" {
  source        = "../../modules/app"
  backend_image = module.ecr.repository_url
}