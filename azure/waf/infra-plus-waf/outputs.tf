output "public_nsip" {
  value = module.infra.public_nsip
}

output "private_nsip" {
  value = module.infra.private_nsip
}

output "public_vip" {
  value = module.infra.public_vip
}

output "private_vip" {
  value = module.infra.private_vip
}

output "private_backend_management_ips" {
  value = module.lb.private_backend_management_ips
}

output "public_backend_management_ips" {
  value = module.lb.public_backend_management_ips
}

output "backend_server_ips" {
  value = module.lb.backend_server_ips
}

output "management_subnet_id" {
  value = module.infra.management_subnet_id
}

output "server_subnet_id" {
  value = module.infra.server_subnet_id
}
