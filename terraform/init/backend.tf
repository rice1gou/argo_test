terraform {
  backend "gcs" {
    bucket = "c78be57dce6b0d4c-argo-test-tfstate"
    prefix = "argo_test/init.tfstate"
  }
}
