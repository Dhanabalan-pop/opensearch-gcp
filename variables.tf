variable "GOOGLE_CREDENTIALS_BASE64" {
  type      = string
  sensitive = true
}
variable "project" {
  type    = string
  default = "arctic-marking-445204-v5"
}
variable "location" {
  type    = string
  default = "us-central1"
}
variable "cluster_name" {
  type    = string
  default = "elastiq-gke-cluster"
}
variable "nodepool_name" {
  type    = string
  default = "elastiq-nodepool"
}
variable "instance_type" {
  type    = string
  default = "e2-medium"
}
