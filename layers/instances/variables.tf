variable "instances_project_id" {
  description = "The GCP instances project ID"
  type        = string
}

variable "network_project_id" {
  description = "The GCP network project ID"
  type        = string
}

variable "instance_roles" {
  description = "Instances roles specifications"
}

variable "instances_region" {
  description = "Region where the instances will be created"
}
