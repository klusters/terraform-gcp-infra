module "network" {
  source  = "terraform-google-modules/network/google"
  version = "~> 4.0"

  project_id   = var.project_id
  network_name = "klusters-infra"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = var.region
      subnet_private_access = true
    },
    {
      subnet_name   = "subnet-02"
      subnet_ip     = "10.10.20.0/24"
      subnet_region = var.region
      subnet_private_access = true
    }
  ]
}

module "net-firewall" {
  source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  project_id   = var.project_id
  network = module.network.network_name
  
  internal_ranges_enabled = false
  internal_ranges         = ["10.0.0.0/0"]
  internal_target_tags    = ["internal"]
  ssh_source_ranges = ["${chomp(data.http.my_public_ip.body)}/32"]
  ssh_target_tags = ["ssh-front"]
  custom_rules = {
    internal-ssh = {
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
    },
    internal-elasticsearch = {
      description          = "Intra cluster ssh rules"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = []
      sources              = ["es-cluster"]
      targets              = ["es-cluster"]
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports    = ["9200", "9300"]
        }
      ]
      extra_attributes = {}
    },

  }
}

module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  project_id = var.project_id
  region     = var.region

  network = module.network.network_name
  create_router     = true
  router = "routername"
}