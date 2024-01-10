variable "network_project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "network_name" {
  description = "Network (=VPC) name"
  type        = string
}

variable "network_region" {
  description = "Network (=VPC) region"
  type        = string
}

variable "network_subnetworks" {
  description = "Subnetworks in network (=VPC)"
  type = list(object({
    subnet_name           = string
    subnet_ip             = string
    subnet_region         = string
    subnet_private_access = string
  }))
}
