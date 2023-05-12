resource "github_repository" "repo" {
  for_each = var.managed_repositories

  name = each.key

  allow_merge_commit     = each.value.settings.allow_merge_commit != null ? each.value.settings.allow_merge_commit : false
  allow_auto_merge       = each.value.settings.allow_auto_merge != null ? each.value.settings.allow_auto_merge : true
  vulnerability_alerts   = each.value.settings.vulnerability_alerts != null ? each.value.settings.vulnerability_alerts : true
  delete_branch_on_merge = each.value.settings.delete_branch_on_merge != null ? each.value.settings.delete_branch_on_merge : true

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}

resource "github_team" "team" {
  for_each = toset(flatten([
    for repo in values(var.managed_repositories) : keys(repo.teams)
  ]))

  name = each.key
}

locals {
  team_repo_map = flatten([
    for repo_name, details in var.managed_repositories : [
      for team_name, role in details.teams : {
        repo_name = repo_name
        team_name = team_name
        role      = role
      }
    ]
  ])

  team_repo_for_each = { for tr in local.team_repo_map : "${tr.repo_name}-${tr.team_name}" => tr }
}

resource "github_team_repository" "team_repo" {
  for_each = local.team_repo_for_each

  repository = github_repository.repo[each.value.repo_name].name
  team_id    = github_team.team[each.value.team_name].id
  permission = each.value.role
}

data "github_repositories" "organization_repos" {
  query = "org:${var.github_organization}"
}

locals {
  unmanaged_repos = [for repo in data.github_repositories.organization_repos.names : repo if !contains(keys(var.managed_repositories), repo)]
}

output "unmanaged_repos" {
  description = "Repositories in the organization not managed by Terraform. To import a repository, use the command `terraform import github_repository.<resource_name> <org>/<repo>`."
  value       = { for repo in local.unmanaged_repos : repo => "The ${repo} repository is not managed by terraform." }
}
