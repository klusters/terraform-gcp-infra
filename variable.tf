variable "region" {
  description = "Region for cloud resources"
  default     = "europe-west1"
}

variable "project_id" {
  type        = string
  description = "The GCP project ID"
  default     = null
}

variable "instance_roles" {
  type    = map
  description = "Instances roles specifications"
  default = {}
}
