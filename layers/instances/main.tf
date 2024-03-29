module "instance_template" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  version              = "10.1.1"

  project_id           = var.instances_project_id
  for_each             = var.instance_roles
  subnetwork           = data.terraform_remote_state.network.outputs.subnets["${var.instances_region}/${each.value.subnetwork}"].name
  subnetwork_project   = var.network_project_id
  service_account      = each.value.service_account
  machine_type         = each.value.machine_type
  preemptible          = each.value.preemptible
  spot                 = each.value.spot
  tags                 = each.value.tags
  source_image         = each.value.source_image
  source_image_project = each.value.source_image_project
  labels               = each.value.labels
  disk_size_gb         = each.value.disk_size_gb
  additional_disks     = each.value.additional_disks
  access_config        = try(each.value.access_config, [])
  can_ip_forward       = try(each.value.can_ip_forward, false)
}

module "compute_instance" {
  source                    = "terraform-google-modules/vm/google//modules/compute_instance"
  version                   = "10.1.1"
  for_each                  = var.instance_roles
  num_instances             = each.value.count
  hostname                  = try(each.value.hostname, "${each.value.labels.app}-${each.value.labels.environment}-${each.value.labels.role}")
  instance_template         = module.instance_template[each.key].self_link
  hostname_suffix_separator = var.hostname_suffix_separator
  deletion_protection       = false
}