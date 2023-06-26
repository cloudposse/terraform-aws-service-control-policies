module "yaml_config" {
  source  = "cloudposse/config/yaml"
  version = "1.0.2"

  list_config_local_base_path = path.module
  list_config_paths           = var.list_config_paths

  parameters = var.parameters

  context = module.this.context
}

data "aws_caller_identity" "this" {}

module "service_control_policies" {
  source = "../../"

  service_control_policy_statements  = module.yaml_config.list_configs
  service_control_policy_description = var.service_control_policy_description
  target_id                          = data.aws_caller_identity.this.account_id

  context = module.this.context
}
