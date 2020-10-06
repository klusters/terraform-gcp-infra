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