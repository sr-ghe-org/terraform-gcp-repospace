/**
* This module standardizes the initialization of a 1-to-many 'repospace' resource set.
*/

# vim: filetype=terraform syntax=terraform softtabstop=2 tabstop=2 shiftwidth=2 fileencoding=utf-8 commentstring=#%s expandtab
# code: language=terraform insertSpaces=true tabSize=2

locals {
  gcp_wif = var.control_repository.wif.gcp != null ? var.control_repository.wif.gcp : {}
}

# setup the control repository.
module "repository" {
  source                 = "app.terraform.io/bankofnovascotia/repo/github"
  version                = ">= 0.1.0, < 1.0.0"
  repository_description = "A control repository for ${var.workload_id} in the ${var.descriptor} context"
  repository_name        = "tfw-tfc-global-saas-${var.descriptor}-${var.workload_id}"
  repository_topics      = var.control_repository.topics
  repository_type = {
    template_name      = var.repository_template,
    template_owner     = "bns-infra"
    gitignore_template = "Terraform"
    license_template   = "None"
  }
  # team_id = var.control_repository.team_id
  wif = {
    gcp = local.gcp_wif
    # hve = var.control_repository.wif.hve
  }
  workload_id = var.workload_id
}


# Set up the workspaces as provided.
# module "workspace" {
#   for_each              = var.workspaces
#   source                = "app.terraform.io/bankofnovascotia/workspace/tfe"
#   version               = ">= 0.0.3, < 1.0.0"
#   additional_policies   = var.additional_policies
#   project_id            = each.value.project_id
#   team_id               = each.value.team_id
#   vcs_repository        = module.repository.repository.full_name
#   vcs_ghain             = var.vcs_ghain
#   wif                   = each.value.wif
#   workload_id           = var.workload_id
#   workspace_access      = "read"
#   workspace_auto_apply  = (each.value.impact == "high") ? false : true
#   workspace_description = "The workspace for the ${each.value.environment} in ${each.value.region} for APM code ${var.workload_id}."
#   workspace_environment = each.value.environment
#   workspace_name        = "tfc-${each.value.region}-${each.value.environment}-${var.descriptor}-${var.workload_id}"
#   workspace_region      = each.value.region
#   workspace_source_name = "terraform-bns-repospace"
#   workspace_source_url  = "https://github.com/bns-infra/terraform-bns-repospace"
#   workspace_tags = [
#     format("type:%s", var.descriptor),
#     format("apm:%s", var.workload_id),
#     format("region:%s", each.value.region),
#     format("environment:%s", each.value.environment)
#   ]
#   workspace_tags_regex        = (each.value.impact == "high") ? "refs/tags/[0-9]+.[0-9]+.[0-9]+" : null
#   workspace_trigger_patterns  = (each.value.impact == "high") ? [] : ["deployments/${each.value.environment}/${each.value.region}/**"]
#   workspace_working_directory = "deployments/${each.value.environment}/${each.value.region}"
#   depends_on                  = [module.repository]
# }

