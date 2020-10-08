
module "managed-instance-groups" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 5.0.0"

  project_id = var.project_id
  region     = var.region

  for_each = var.instance_roles

  hostname          = each.value.instance_name
  instance_template = module.instances-templates[each.key].self_link

  subnetwork = module.subnets.subnets["${var.region}/${each.value.subnetwork}"].name

  autoscaling_enabled = false

  target_size = each.value.count

}

## autoscaling
## named ports
## replicas