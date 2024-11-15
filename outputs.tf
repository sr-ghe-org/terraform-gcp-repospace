# vim: filetype=terraform syntax=terraform softtabstop=2 tabstop=2 shiftwidth=2 fileencoding=utf-8 commentstring=#%s expandtab
# code: language=terraform insertSpaces=true tabSize=2

output "repository" {
  description = "The github repository created for the VCS workflow instance."
  value       = module.repository
}

# output "workspace" {
#   description = "The terraform cloud workspaces for the VCS workflow instance."
#   value       = module.workspace
# }

