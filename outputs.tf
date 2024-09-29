output "organizations_policy_id" {
  value       = one([ for i in aws_organizations_policy.this : i.id])
  description = "The unique identifier of the policy"
}

output "organizations_policy_arn" {
  value       = one([ for i in aws_organizations_policy.this : i.arn])
  description = "Amazon Resource Name (ARN) of the policy"
}

output "organizations_policy_ids" {
  value       = [ for i in aws_organizations_policy.this : i.id]
  description = "The unique identifier of the policies"
}

output "organizations_policy_arns" {
  value       = [ for i in aws_organizations_policy.this : i.arn]
  description = "Amazon Resource Name (ARN) of the policies"
}
