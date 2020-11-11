output "organizations_policy_id" {
  value       = module.service_control_policies.organizations_policy_id
  description = "The unique identifier of the policy"
}

output "organizations_policy_arn" {
  value       = module.service_control_policies.organizations_policy_arn
  description = "Amazon Resource Name (ARN) of the policy"
}
