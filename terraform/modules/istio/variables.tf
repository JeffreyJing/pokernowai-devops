variable "istio_version" {
  type    = string
  default = "1.22.1" # pick a stable version
}

variable "kubeconfig_path" {
  type    = string
  default = "~/.kube/config"
}
