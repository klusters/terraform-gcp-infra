module "instances-templates" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"

  project_id = var.project_id
  region     = var.region

  service_account = {
    scopes = ["userinfo-email", "compute-rw", "storage-ro"]
    email  = data.google_compute_default_service_account.default.email
  }

  for_each    = var.instance_roles
  name_prefix = each.value.instance_name

  subnetwork         = module.network.subnets["${var.region}/${each.value.subnetwork}"].name
  subnetwork_project = var.project_id

  disk_size_gb = each.value.disk_size_gb

  source_image_project = each.value.source_image_project
  source_image_family  = each.value.source_image_family

  labels = each.value.labels

  access_config = each.value.access_config != "" ? each.value.access_config : []

  tags = each.value.tags

  machine_type = each.value.machine_type

  preemptible = each.value.preemptible

  additional_disks = each.value.additional_disks
}
