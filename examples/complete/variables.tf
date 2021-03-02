variable "region" {
  type        = string
  description = "AWS region"
}

variable "service_control_policy_description" {
  type        = string
  default     = null
  description = "Description of the combined Service Control Policy"
}

variable "service_control_policy_paths" {
  type        = list(string)
  description = "List of paths to Service Control Policy configurations"
}

variable "parameters" {
  type        = map(string)
  description = "Map of parameters for interpolation within the YAML config templates"
  default     = {}
}
variable "list_config_paths" {
  type        = list(string)
  description = "Paths to YAML configuration files of list type"
  default     = []
}
