data "github_repositories" "organization_repos" {
  query = "org:${var.github_organization}"
}

resource "github_repository" "enable_security_alerts" {
  for_each = { for repo in data.github_repositories.organization_repos.names : repo => repo }

  name = each.key

  allow_merge_commit     = false
  allow_auto_merge       = true
  vulnerability_alerts   = true
  delete_branch_on_merge = true

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}
