module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 2.5.0"

  project_id   = var.project_id
  network_name = "klusters-infra"

  shared_vpc_host = false
}

module "subnets" {
  source  = "terraform-google-modules/network/google//modules/subnets-beta"
  version = "~> 2.5.0"

  project_id   = var.project_id
  network_name = module.vpc.network_name

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "europe-west1"
    },
    {
      subnet_name   = "subnet-02"
      subnet_ip     = "10.10.20.0/24"
      subnet_region = "europe-west1"
    }
  ]
}

## vars : vpc name, subnets name, regions and ip

module "net-firewall" {
  source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  version = "~> 2.5.0"
  project_id   = var.project_id
  network = module.vpc.network_name
  
  internal_ranges_enabled = false
  internal_ranges         = ["10.0.0.0/0"]
  internal_target_tags    = ["internal"]
  ssh_source_ranges = ["82.64.75.188/32"]
  ssh_target_tags = ["ssh-front"]
  custom_rules = {
    ingress-sample = {
      description          = "SSH from jump host / bastion"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = []
      sources              = ["ssh-front"]
      targets              = ["ssh-back"]
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
      extra_attributes = {}
    }
  }
}

module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 1.2"
  project_id = var.project_id
  region     = var.region

  network = module.vpc.network_name
  create_router     = true
  router = "routername"
}