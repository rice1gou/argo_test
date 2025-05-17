terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.15.0"
    }
  }
  backend "gcs" {}
}

provider "google" {
  project = var.project_id
  region  = var.region_name
  zone    = var.zone_name
}

locals {
  pod_ip_range_name     = "pod-ip-range"
  service_ip_range_name = "service-ip-range"
  labels = {
    project = "${var.project_id}"
    service = "${var.service_name}"
  }
}

module "network" {
  source                = "./modules/network"
  project_id            = var.project_id
  service_name          = var.service_name
  region_name           = var.region_name
  zone_name             = var.zone_name
  pod_ip_range_name     = local.pod_ip_range_name
  service_ip_range_name = local.service_ip_range_name
  labels                = local.labels

}

module "k8s" {
  source                = "./modules/k8s"
  project_id            = var.project_id
  service_name          = var.service_name
  region_name           = var.region_name
  zone_name             = var.zone_name
  vpc_name              = module.network.vpc_name
  manage_subnet_name    = module.network.manage_k8s_subnet_name
  workload_subnet_name  = module.network.workload_k8s_subnet_name
  pod_ip_range_name     = local.pod_ip_range_name
  service_ip_range_name = local.service_ip_range_name
  labels                = local.labels
}
