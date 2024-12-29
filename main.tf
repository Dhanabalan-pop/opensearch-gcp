module "elastiq-gke" {
  source  = "./modules"
  location = "us-central1"
  project ="arctic-marking-445204-v5"
  cluster_name = "gke-cluster"
  nodepool_name ="elastiq-nodepool"
  instance_type = "e2-medium"
}