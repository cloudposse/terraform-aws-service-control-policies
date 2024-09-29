enabled = true

region = "us-east-2"

namespace = "eg"

stage = "test"

name = "scp"

service_control_policy_description = "Test Service Control Policy"

list_config_paths = [
  "../../catalog/account-policies.yaml",
  "../../catalog/cloudtrail-policies.yaml",
  "../../catalog/cloudwatch-logs-policies.yaml",
  "../../catalog/config-policies.yaml",
  "../../catalog/deny-all-policies.yaml",
]

parameters = {
  ami_creator_account = "account_creator"
  ami_tag_key         = "ami_tag_key"
  ami_tag_value       = "ami_tag_value"
  allowed_regions     = "eu-central-1, eu-west-1"
  denied_regions      = "sa-east-1"
  s3_regions_lockdown = "eu-central-1, eu-west-1"
}
