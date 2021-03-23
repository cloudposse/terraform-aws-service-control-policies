variable "service_control_policy_statements" {
  type        = any
  description = "List of Service Control Policy statements"
}

variable "service_control_policy_description" {
  type        = string
  default     = null
  description = "Description of the combined Service Control Policy"
}

variable "target_id" {
  type        = string
  description = "The unique identifier (ID) of the organization root, organizational unit, or account number that you want to attach the policy to"
}

variable "region_lockdown" {
  type    = List
  default = ["eu-central-1", "eu-west-1"]
}
