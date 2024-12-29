/* resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
} */
data "google_project" "project" {
  project_id = var.project  # Replace with your actual project ID
}
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  workload_identity_config {
  workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
}
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.nodepool_name
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.instance_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
   #  service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  
}
# Enable Workload Identity on IAM for Kubernetes Service Accounts (KSA) and GCP Service Accounts (GSA)
resource "google_service_account" "gke_service_account" {
  account_id   = "gke-service-account"
  display_name = "Service Account for Workload Identity"
}

resource "google_project_iam_member" "service_account_member" {
  project = var.project
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${google_service_account.gke_service_account.email}"
}