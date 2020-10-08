## SSH key can only be provided by end user. Impersonation needed

data "google_service_account_access_token" "ansible_sa" {
  provider               = google
  target_service_account = module.ansible_sa.email
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "30s"
}

provider "google" {
  alias        = "impersonated"
  access_token = data.google_service_account_access_token.ansible_sa.access_token
}

resource "google_os_login_ssh_public_key" "cache" {
  provider = google.impersonated
  
  user =  module.ansible_sa.email
  key = file(var.ssh_public_key)
}
