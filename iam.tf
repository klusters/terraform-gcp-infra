module "ansible_sa" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 3.0"
  project_id    = var.project_id
  names         = ["ansible-sa"]
  display_name  = "ansible-sa"
  generate_keys = true
  project_roles = [
    "${var.project_id}=>roles/compute.instanceAdmin",
    "${var.project_id}=>roles/compute.osAdminLogin",
    "${var.project_id}=>roles/iam.serviceAccountUser"
  ]
}

## SSH key can only be provided by end user. Impersonation needed
module "service_account-iam-bindings" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"
  version       = "~> 6.3"
  project          = var.project_id

  service_accounts = [module.ansible_sa.email]
  mode             = "authorative"
  bindings = {
    "roles/iam.serviceAccountTokenCreator" = [
      "serviceAccount:${data.google_client_openid_userinfo.me.email}"
      ]
    }
}