module "network" {
  source = "terraform-google-modules/network/google"

  project_id   = var.network_project_id
  network_name = var.network_name
  routing_mode = "GLOBAL"

  subnets = var.network_subnetworks
}