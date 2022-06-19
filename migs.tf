
module "managed-instance-groups" {
  source  = "terraform-google-modules/vm/google//modules/mig"

  project_id = var.project_id
  region     = var.region

  for_each = var.instance_roles

  hostname          = each.value.instance_name
  instance_template = module.instances-templates[each.key].self_link

  subnetwork = module.network.subnets["${var.region}/${each.value.subnetwork}"].name

  autoscaling_enabled = false

  distribution_policy_zones = each.value.distribution_policy_zones
  target_size = each.value.count
  named_ports = each.value.named_ports
}

## autoscaling
## named ports
## replicas