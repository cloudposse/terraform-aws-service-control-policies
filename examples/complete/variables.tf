variable "region" {
  type        = string
  description = "AWS region"
}

variable "service_control_policy_description" {
  type        = string
  default     = null
  description = "Description of the combined Service Control Policy"
}
