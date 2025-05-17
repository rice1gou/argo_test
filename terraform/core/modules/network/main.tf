
locals {
  manage_gke = {
    subnet_ip_range = "10.0.1.0/24"
    pod_ip_range_name = var.pod_ip_range_name
    pod_ip_range = "10.4.0.0/14"
    service_ip_range_name = var.service_ip_range_name
    service_ip_range = "10.96.0.0/20"
  }
  workload_gke = {
    subnet_ip_range = "10.0.2.0/24"
    pod_ip_range_name = var.pod_ip_range_name
    pod_ip_range = "10.8.0.0/14"
    service_ip_range_name = var.service_ip_range_name
    service_ip_range = "10.112.0.0/20"
  }
}
resource "google_compute_network" "vnet" {
  name                    = "${var.service_name}-vnet"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "manage_k8s" {
  name          = "${var.service_name}-subnet-manage-k8s"
  ip_cidr_range = local.manage_gke.subnet_ip_range
  region        = var.region_name
  network       = google_compute_network.vnet.id

  secondary_ip_range {
    range_name    = local.manage_gke.pod_ip_range_name
    ip_cidr_range = local.manage_gke.pod_ip_range
  }

  secondary_ip_range {
    range_name    = local.manage_gke.service_ip_range_name
    ip_cidr_range = local.manage_gke.service_ip_range
  }
}

resource "google_compute_subnetwork" "workload_k8s" {
  name          = "${var.service_name}-subnet-workload-k8s"
  ip_cidr_range = local.workload_gke.subnet_ip_range
  region        = var.region_name
  network       = google_compute_network.vnet.id

  secondary_ip_range {
    range_name    = local.workload_gke.pod_ip_range_name
    ip_cidr_range = local.workload_gke.pod_ip_range
  }

  secondary_ip_range {
    range_name    = local.workload_gke.service_ip_range_name
    ip_cidr_range = local.workload_gke.service_ip_range
  }
}

resource "google_compute_router" "nat-router" {
  name    = "${var.service_name}-nat-router"
  region  = var.region_name
  network = google_compute_network.vnet.name
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat-config"
  router                             = google_compute_router.nat-router.name
  region                             = var.region_name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

output "vpc_id" {
  value = google_compute_network.vnet.id
}

output "vpc_name" {
  value = google_compute_network.vnet.name
}

output "vpc_self_link" {
  value = google_compute_network.vnet.self_link
}

output "manage_k8s_subnet_name" {
  value = google_compute_subnetwork.manage_k8s.name
}

output "workload_k8s_subnet_name" {
  value = google_compute_subnetwork.workload_k8s.name
}
