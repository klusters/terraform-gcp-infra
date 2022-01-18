provider "google" {

  project = var.project_id
  region  = var.region

}


data "google_compute_default_service_account" "default" {}
data "google_client_openid_userinfo" "me" {}

data "http" "my_public_ip" {
  url = "https://ifconfig.co/ip"
}