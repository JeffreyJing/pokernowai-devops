variable "kubeconfig_path" {
  type    = string
  default = "~/.kube/config"
}

variable "namespace" {
  type    = string
  default = "backend"
}

variable "backend_image" {
  type = string
  # example: 123456789012.dkr.ecr.us-east-1.amazonaws.com/pokernowai-backend:latest
}
