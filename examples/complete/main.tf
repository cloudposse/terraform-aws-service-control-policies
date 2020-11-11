locals {
  service_control_policy_statements = flatten(
    [
      for file in fileset(path.module, "policies/*.yaml") : [
        for k, v in yamldecode(file(format("%s/%s", path.module, file))) : v
      ]
    ]
  )
}

data "aws_organizations_organization" "this" {}

module "service_control_policies" {
  source = "../../"

  service_control_policy_statements  = local.service_control_policy_statements
  service_control_policy_description = var.service_control_policy_description
  target_id                          = data.aws_organizations_organization.this.roots[0].id

  context = module.this.context
}
