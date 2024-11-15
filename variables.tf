# vim: filetype=terraform syntax=terraform softtabstop=2 tabstop=2 shiftwidth=2 fileencoding=utf-8 commentstring=#%s expandtab
# code: language=terraform insertSpaces=true tabSize=2

variable "additional_policies" {
  description = "What additional policies does the role require."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "control_repository" {
  description = "The details associated with the control repositories."
  type = object({
    # team_id = string
    topics  = list(any)
    wif = object({
      gcp = optional(map(object({
        service_account = string
        sa_project_id   = string
        project_number  = string
        pool_id         = string
        provider_id     = string
      }))),
      # hve = object({
      #   address   = string
      #   auth_path = string
      #   namespace = string
      # })
    })
  })
}

variable "descriptor" {
  description = "A string describing the repospace."
  type        = string
  nullable    = false
}

variable "repository_template" {
  description = "The control repository template to instantiate the control repository with."
  type        = string
  nullable    = false
  default     = "tf-appcode-template"
}

variable "vcs_ghain" {
  description = "The TFC Github Application Installation."
  type        = string
  nullable    = false
}

variable "workload_id" {
  description = "The Application Portfolio Management (APM) Code for the workload."
  type        = string
  nullable    = false
  validation {
    condition     = can(regex("^[a-z][a-z][a-z][a-z]$", var.workload_id))
    error_message = "The APM code is expected to be a 4 alphabetic (lower-case) character string."
  }
}

# variable "workspaces" {
#   description = "The set of environments to establish workspaces for"
#   type = map(object({
#     environment = string
#     impact      = string
#     project_id  = string
#     region      = string
#     team_id     = string
#     wif = object({
#       gcp = object({
#         service_account = string
#         sa_project_id   = string
#         project_number  = string
#         pool_id         = string
#         provider_id     = string
#       })
#       # hve = object({
#       #   address   = string
#       #   auth_path = string
#       #   namespace = string
#       # })
#     })
#   }))
# }
