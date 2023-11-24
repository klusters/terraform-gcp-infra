module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.fw_rules_project_id
  network_name = data.terraform_remote_state.network.outputs.network_name

  rules = var.fw_rules

}