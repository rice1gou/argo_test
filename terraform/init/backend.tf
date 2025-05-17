terraform {
  backend "gcs" {
    bucket = "5c2636e6ce245a56-argo_test-tfstate"
    prefix = "argo_test/init.tfstate"
  }
}
