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
  region_lockdown     = ["us-east-1", "eu-west-1"]
}
