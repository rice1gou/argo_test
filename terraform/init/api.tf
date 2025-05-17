locals {
  activate_apis = toset([
    # GKE
    "container.googleapis.com",
    # Cloud Storage
    "storage.googleapis.com",
    # Secret Manager
    "secretmanager.googleapis.com",
    # Cloud SQL Auth Proxy
    "sqladmin.googleapis.com",
    # Private Connection
    "servicenetworking.googleapis.com"
  ])
}
# APIの有効化処理
resource "google_project_service" "apis" {
  for_each = local.activate_apis
  project  = var.project_id
  service  = each.value
}