enabled = true

region = "us-east-2"

namespace = "eg"

stage = "test"

name = "scp"

service_control_policy_description = "Test Service Control Policy"

service_control_policy_paths = ["../../catalog/*.yaml"]

parameters = {
  ami_creator_account = "account_creator"
  ami_tag_key         = "ami_tag_key"
  ami_tag_value       = "ami_tag_value"
  region1_lockdown    = "us-east-1"
  region2_lockdown    = "eu-west-1"
}
