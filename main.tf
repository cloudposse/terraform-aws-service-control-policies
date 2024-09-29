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
  for_each = module.this.enabled ? local.service_control_policy_statements_map : {}

  statement {
    sid         = each.value.sid
    effect      = each.value.effect
    actions     = try(each.value.actions, null)
    not_actions = try(each.value.not_actions, null)
    resources   = each.value.resources

    dynamic "condition" {
      for_each = try(each.value.condition, null) != null ? each.value.condition : []

      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

resource "aws_organizations_policy" "this" {
  for_each    = module.this.enabled ? local.service_control_policy_statements_map : {}
  name        = join(module.this.id, "-", each.key)
  description = var.service_control_policy_description
  content = jsonencode(
    {
      Version   = try(jsondecode(data.aws_iam_policy_document.this[each.key].json).Version, null)
      Statement = jsondecode(data.aws_iam_policy_document.this[each.key].json).Statement
    }
  )
  tags = module.this.tags
}

resource "aws_organizations_policy_attachment" "this" {
  for_each  = module.this.enabled ? local.service_control_policy_statements_map : {}
  policy_id = join("", aws_organizations_policy.this[each.key].id)
  target_id = var.target_id
}
