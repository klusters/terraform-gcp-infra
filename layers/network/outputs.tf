output "network_name" {
  description = "The name of the VPC being created"
  value       = module.network.network_name
}

output "subnets" {
  description = "	The self-links of subnets being created"
  value       = module.network.subnets
}
