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
  "../../catalog/ec2-policies.yaml",
  "../../catalog/guardduty-policies.yaml",
  "../../catalog/iam-policies.yaml",
  "../../catalog/kms-policies.yaml",
  "../../catalog/region-specific-policies.yaml"
]

parameters = {
  ami_creator_account = "account_creator"
  ami_tag_key         = "ami_tag_key"
  ami_tag_value       = "ami_tag_value"
  regions_lockdown    = "denied_region_1, denied_region_2"
  s3_regions_lockdown = "denied_s3_region_1,denied_s3_region_2"
}
