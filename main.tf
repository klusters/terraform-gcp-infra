provider "google" {

  project = var.project_id
  region  = var.region

  version = "~> 3.0"

}


data "google_compute_default_service_account" "default" {}
data "google_client_openid_userinfo" "me" {}