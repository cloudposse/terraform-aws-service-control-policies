locals {
  service_control_policy_content = {
    Statement = var.service_control_policy_statements
  }
}

resource "aws_organizations_policy" "this" {
  count       = module.this.enabled ? 1 : 0
  name        = module.this.id
  description = var.service_control_policy_description
  content     = jsonencode(local.service_control_policy_content)
  tags        = module.this.tags
}

resource "aws_organizations_policy_attachment" "this" {
  count     = module.this.enabled ? 1 : 0
  policy_id = join("", aws_organizations_policy.this.*.id)
  target_id = var.target_id
}
