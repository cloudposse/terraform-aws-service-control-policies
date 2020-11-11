data "aws_iam_policy_document" "this" {
  count     = module.this.enabled ? 1 : 0
  statement = var.service_control_policy_statements
}

resource "aws_organizations_policy" "this" {
  count       = module.this.enabled ? 1 : 0
  name        = module.this.id
  description = var.service_control_policy_description
  content     = join("", data.aws_iam_policy_document.this.*.json)
}

resource "aws_organizations_policy_attachment" "this" {
  count     = module.this.enabled ? 1 : 0
  policy_id = join("", aws_organizations_policy.this.*.id)
  target_id = var.target_id
}
