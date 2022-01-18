module "ansible_sa" {
  source        = "terraform-google-modules/service-accounts/google"
  project_id    = var.project_id
  names         = [var.ansible_sa_name]
  display_name  = var.ansible_sa_name
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
  project          = var.project_id

  service_accounts = [module.ansible_sa.email]
  mode             = "authorative"
  bindings = {
    "roles/iam.serviceAccountTokenCreator" = [
      "serviceAccount:${data.google_client_openid_userinfo.me.email}"
      ]
    }
}