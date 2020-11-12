locals {
  service_control_policy_statements_map = { for i in var.service_control_policy_statements : i.sid => i }

  statements = flatten([for i in data.aws_iam_policy_document.this : jsondecode(i.json).Statement])
  version    = try(jsondecode(values(data.aws_iam_policy_document.this)[0].json).Version, null)

  service_control_policy_json = jsonencode(
    {
      Version   = local.version
      Statement = local.statements
    }
  )
}

data "aws_iam_policy_document" "this" {
  for_each = local.service_control_policy_statements_map

  statement {
    sid         = each.value.sid
    effect      = each.value.effect
    actions     = try(each.value.actions, null)
    not_actions = try(each.value.not_actions, null)
    resources   = each.value.resources

    dynamic "condition" {
      for_each = try(each.value.condition, null) != null ? [true] : []

      content {
        test     = each.value.condition.test
        variable = each.value.condition.variable
        values   = each.value.condition.values
      }
    }
  }
}

resource "aws_organizations_policy" "this" {
  count       = module.this.enabled ? 1 : 0
  name        = module.this.id
  description = var.service_control_policy_description
  content     = local.service_control_policy_json
  tags        = module.this.tags
}

resource "aws_organizations_policy_attachment" "this" {
  count     = module.this.enabled ? 1 : 0
  policy_id = join("", aws_organizations_policy.this.*.id)
  target_id = var.target_id
}
