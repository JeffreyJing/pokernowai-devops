module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"  # use latest v20

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  subnet_ids      = var.private_subnet_ids
  vpc_id          = var.vpc_id

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      desired_size = 1
      max_size     = 2
      min_size     = 1

      instance_types = ["t3.medium"]
      ami_type       = "AL2_x86_64"

      name = "node-group"
      iam_role_arn = var.node_role_arn
    }
  }

  create_iam_role = false
  iam_role_arn    = var.cluster_role_arn

  tags = {
    Name = var.cluster_name
  }
}
