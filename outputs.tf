output "organizations_policy_id" {
  value       = join("", aws_organizations_policy.this.*.id)
  description = "The unique identifier of the policy"
}

output "organizations_policy_arn" {
  value       = join("", aws_organizations_policy.this.*.arn)
  description = "Amazon Resource Name (ARN) of the policy"
}
