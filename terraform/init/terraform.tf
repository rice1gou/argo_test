terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.15.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region_name
  zone    = var.zone_name
}
