# Configure the Google Cloud provider
provider "google" {
  credentials = base64decode((var.GOOGLE_CREDENTIALS_BASE64))  # Path to your service account key file
  project     = "arctic-marking-445204-v5"  # Your Google Cloud project ID
  region      = "us-central1"        # The region you want to use (optional, but good practice)
}
