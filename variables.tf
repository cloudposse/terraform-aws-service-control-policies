variable "service_control_policy_statements" {
  type = list(object({
    sid           = string
    effect        = string
    actions       = list(string)
    not_actions   = list(string)
    resources     = list(string)
    not_resources = list(string)
    principals = object({
      type        = string
      identifiers = list(string)
    })
    not_principals = object({
      type        = string
      identifiers = list(string)
    })
    condition = list(object({
      test     = string
      variable = string
      values   = list(string)
    }))
  }))
  description = "Service Control Policy statements"
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
