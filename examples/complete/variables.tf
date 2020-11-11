variable "region" {
  type        = string
  description = "AWS region"
}

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
