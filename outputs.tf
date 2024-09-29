output "organizations_policy_id" {
  value       = one([for k, v in aws_organizations_policy.this : v.id])
  description = "The unique identifier of the policy"
}

output "organizations_policy_arn" {
  value       = one([for k, v in aws_organizations_policy.this : v.arn])
  description = "Amazon Resource Name (ARN) of the policy"
}

output "organizations_policy_ids" {
  value       = [for k, v in aws_organizations_policy.this : v.id]
  description = "The unique identifier of the policies"
}

output "organizations_policy_arns" {
  value       = [for k, v in aws_organizations_policy.this : v.arn]
  description = "Amazon Resource Name (ARN) of the policies"
}
