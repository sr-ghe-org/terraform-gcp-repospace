
mock_provider "github" {}
mock_provider "tfe"    {}
mock_provider "vault"  {}
mock_provider "google" {}
mock_provider "google-beta" {}

# dummy values which are provided by the context
variables {
  additional_policies = ["a/b/c"]
  control_repository = {
    team_id     = "abcdef"
    topics      = ["testa", "testb"]
    wif = {
      gcp = {
        test_one = {
          service_account = "prsdfsdf@dummysa.iam.gserviceaccount.com"
          sa_project_id   = "dummypr"
          project_number  = "prblah"
          pool_id         = "prtestpool"
          provider_id     = "prtestprovider"
        }
      },
      hve = {
        address           = "blah.bloo.blee"
        namespace         = "doesnotexist"
        auth_path         = "/foo/fee/fum"
      }
    }
  }
  descriptor  = "sample"
  vcs_ghain   = "akjhsdflkjh"
  workload_id = "abcd"
  workspaces = {
    "envA" = {
      environment         = "envA"
      impact              = "low"
      project_id          = "abcdef"
      region              = "global"
      team_id             = "xcvbvn"
      wif = {
        gcp = {
          service_account = "prsdfsdf@dummysa.iam.gserviceaccount.com"
          sa_project_id   = "dummypr"
          project_number  = "prblah"
          pool_id         = "prtestpool"
          provider_id     = "prtestprovider"
        },
        hve = {
          address           = "blah.bloo.blee"
          namespace         = "doesnotexist"
          auth_path         = "/foo/fee/fum"
        }
      }
    },
    "envB" = {
      environment         = "envB"
      impact              = "high"
      project_id          = "abcdef"
      region              = "global"
      team_id             = "xcvbvn"
      wif = {
        gcp = {
          service_account = "npsdfsdf@dummysa.iam.gserviceaccount.com"
          sa_project_id   = "dummynp"
          project_number  = "npblah"
          pool_id         = "nptestpool"
          provider_id     = "nptestprovider"
        },
        hve = {
          address           = "blah.bloo.blee"
          namespace         = "doesnotexist"
          auth_path         = "/foo/fee/fum"
        }
      }
    }
  } 
}

# ensure we can do a clean run.
run "clean_run" {
  command = plan

  assert {
    condition     = output.repository.repository.name == "tfw-tfc-global-saas-sample-abcd"
    error_message = "The expectation is that we created a control repository with the right name."
  }

  assert {
    condition     = length(keys(output.workspace)) == 2 && length(output.workspace.envA.workspace.vcs_repo) == 1 && length(output.workspace.envB.workspace.vcs_repo) == 1
    error_message = "The expectation is that we created two workspaces that correspond to the control repository."
  }

  assert {
    condition     = output.workspace.envA.workspace.file_triggers_enabled == true && length(output.workspace.envA.workspace.trigger_patterns) > 0 && output.workspace.envA.workspace.vcs_repo[0].tags_regex == null
    error_message = "The expectation is that the 'envA' workspace should have file triggers enabled for the appropriate working directory."
  }

  assert {
    condition     = output.workspace.envB.workspace.file_triggers_enabled == false && length(output.workspace.envB.workspace.trigger_patterns) == 0 && output.workspace.envB.workspace.vcs_repo[0].tags_regex != null
    error_message = "The expectation is that the 'envB' workspace should have file triggers disabled and the appropriate regex setup to poll for tags."
  }

}
