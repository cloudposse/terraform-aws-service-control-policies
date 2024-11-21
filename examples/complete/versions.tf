terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.49"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.3"
    }
  }
}
