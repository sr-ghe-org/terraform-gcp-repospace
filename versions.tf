# vim: filetype=terraform syntax=terraform softtabstop=2 tabstop=2 shiftwidth=2 fileencoding=utf-8 commentstring=#%s expandtab
# code: language=terraform insertSpaces=true tabSize=2

# ---------------------------------------------------------------------------------------------------------------------
# SET TERRAFORM AND PROVIDER REQUIREMENTS FOR RUNNING THIS MODULE
# ---------------------------------------------------------------------------------------------------------------------

# terraform {
#   required_version = "~> 1.8"
#   required_providers {
#     tfe = {
#       source  = "hashicorp/tfe"
#       version = "~> 0.58"
#     }
#     github = {
#       source  = "integrations/github"
#       version = ">= 6.0"
#     }
#   }
# }

terraform {
  required_version = ">= 0.13.0"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.58"
    }
    github = {
      source  = "integrations/github"
      version = ">= 6.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.4"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 5.33, < 6"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.33, < 6"
    }
  }
}
