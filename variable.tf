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

variable "ssh_public_key" {
  description = "SSH public key path to authorize"
  default     = "~/.ssh/id_rsa.pub"
}

variable "ansible_sa_name" {
  type = string
  default = "ansible-sa"
}