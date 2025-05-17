locals {
  labels = {
    project     = "${var.project_id}"
    owner_name  = "${var.service_name}"
  }
}

# バケットID用
resource "random_id" "rid" {
  byte_length = 8
}

resource "google_storage_bucket" "tfstate" {
  name                        = "${random_id.rid.hex}-${var.service_name}-tfstate"
  location                    = var.region_name
  force_destroy               = true
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
  labels                      = local.labels
  versioning {
    enabled = true
  }
  depends_on = [google_project_service.apis]
}