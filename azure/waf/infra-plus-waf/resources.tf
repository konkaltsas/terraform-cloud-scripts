module "infra" {
  source = "../infra"

  location = var.location

  resource_group_name = var.resource_group_name

  virtual_network_address_space    = var.virtual_network_address_space
  management_subnet_address_prefix = var.management_subnet_address_prefix
  client_subnet_address_prefix     = var.client_subnet_address_prefix
  server_subnet_address_prefix     = var.server_subnet_address_prefix

  adc_admin_password = var.adc_admin_password

  controlling_subnet = var.controlling_subnet
}

module "adc" {
  source = "../adc"

  resource_group_name = var.resource_group_name

  location = var.location

  management_subnet_id = module.infra.management_subnet_id
  server_subnet_id     = module.infra.server_subnet_id

  private_vip = module.infra.private_vip
  nsip        = module.infra.public_nsip

  adc_admin_password = var.adc_admin_password
}

module "lb" {
  source = "../lb"

  resource_group_name = var.resource_group_name

  location = var.location

  management_subnet_id = module.infra.management_subnet_id
  server_subnet_id     = module.infra.server_subnet_id

  private_vip = module.infra.private_vip
  nsip        = module.infra.public_nsip

  adc_admin_password = var.adc_admin_password
}

module "waf" {
  source = "../waf"

  resource_group_name = var.resource_group_name

  location = var.location

  management_subnet_id = module.infra.management_subnet_id
  server_subnet_id     = module.infra.server_subnet_id

  private_vip = module.infra.private_vip
  nsip        = module.infra.public_nsip

  adc_admin_password = var.adc_admin_password
}
