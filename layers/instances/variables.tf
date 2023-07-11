variable "instances_project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "instance_roles" {
  description = "Instances roles specifications"
}

variable "region" {
  description = "Region where the instances will be created"
}