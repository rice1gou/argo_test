module "manage_gke" {
  source                      = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                  = var.project_id
  name                        = "${var.service_name}-manage-k8s"
  region                      = var.region_name
  zones                       = ["${var.zone_name}"]
  network                     = var.vpc_name
  subnetwork                  = var.manage_subnet_name
  ip_range_pods               = var.pod_ip_range_name
  ip_range_services           = var.service_ip_range_name
  horizontal_pod_autoscaling  = true
  enable_private_endpoint     = false
  enable_private_nodes        = true
  deletion_protection         = false
  cluster_resource_labels     = var.labels
  enable_binary_authorization = true
  gateway_api_channel         = "CHANNEL_STANDARD"
}

module "workload_gke" {
  source                      = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                  = var.project_id
  name                        = "${var.service_name}-workload-k8s"
  region                      = var.region_name
  zones                       = ["${var.zone_name}"]
  network                     = var.vpc_name
  subnetwork                  = var.manage_subnet_name
  ip_range_pods               = var.pod_ip_range_name
  ip_range_services           = var.service_ip_range_name
  horizontal_pod_autoscaling  = true
  enable_private_endpoint     = false
  enable_private_nodes        = true
  deletion_protection         = false
  cluster_resource_labels     = var.labels
  enable_binary_authorization = true
  gateway_api_channel         = "CHANNEL_STANDARD"
}

output "manage_gke_endpoint" {
  value = module.manage_gke.endpoint
}

output "ca_certificate_manage" {
  value = module.manage_gke.ca_certificate
}

output "workload_gke_endpoint" {
  value = module.workload_gke.endpoint
}

output "ca_certificate_workload" {
  value = module.workload_gke.ca_certificate
}