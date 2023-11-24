resource "google_compute_router" "router" {
  project = module.network.project_id
  name    = "${var.network_name}-nat-router"
  network = var.network_name
  region  = var.network_region
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  project_id                         = module.network.project_id
  region                             = var.network_region
  router                             = google_compute_router.router.name
  name                               = "${var.network_name}-nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}