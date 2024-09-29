locals {
  ids  = set([for k, v in aws_organizations_policy.this : v.id])
  arns = set([for k, v in aws_organizations_policy.this : v.arn])
}

output "organizations_policy_id" {
  value       = one(local.ids)
  description = "The unique identifier of the policy"
}

output "organizations_policy_arn" {
  value       = one(local.arns)
  description = "Amazon Resource Name (ARN) of the policy"
}

output "organizations_policy_ids" {
  value       = local.ids
  description = "The unique identifier of the policies"
}

output "organizations_policy_arns" {
  value       = local.arns
  description = "Amazon Resource Name (ARN) of the policies"
}
