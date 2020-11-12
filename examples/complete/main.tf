locals {
  service_control_policy_statements = flatten(
    [
      for file in fileset(path.module, "policies/*.yaml") : [
        for k, v in yamldecode(file(format("%s/%s", path.module, file))) : v
      ]
    ]
  )
}

data "aws_caller_identity" "this" {}

module "service_control_policies" {
  source = "../../"

  service_control_policy_statements  = local.service_control_policy_statements
  service_control_policy_description = var.service_control_policy_description
  target_id                          = data.aws_caller_identity.this.account_id

  context = module.this.context
}
