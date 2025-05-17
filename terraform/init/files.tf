resource "local_file" "init" {
  file_permission = "0644"
  filename        = "./backend.tf"
  content         = <<-EOT
    terraform {
      backend "gcs" {
        bucket = "${google_storage_bucket.tfstate.name}"
        prefix = "argo_test/init.tfstate"
      }
    }
  EOT
}

resource "local_file" "core" {
  file_permission = "0644"
  filename        = "../core/backend.tfvars"
  content         = <<-EOT
    bucket = "${google_storage_bucket.tfstate.name}"
    prefix = "argo_test/core.tfstate"
  EOT
}
