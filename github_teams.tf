resource "github_team" "parent_teams" {
  for_each = var.parent_teams

  name        = each.key
  description = each.value.description
  privacy     = each.value.privacy
}

resource "github_team" "teams" {
  for_each = var.teams

  name           = each.key
  description    = each.value.description
  privacy        = each.value.privacy
  parent_team_id = github_team.parent_teams[each.value.parent_team].id
}

# Get all the teams in the organization
data "github_organization_teams" "all" {}

# Define managed teams
locals {
  managed_teams = merge(var.parent_teams, var.teams)
}

# Define unmanaged teams
locals {
  unmanaged_teams = [for team in data.github_organization_teams.all.teams : team.slug if !contains(keys(local.managed_teams), team.slug)]
}

# Output the list of unmanaged teams
output "unmanaged_teams" {
  value       = [for team in local.unmanaged_teams : "The ${team} team is not managed by Terraform."]
  description = "List of teams that exist on GitHub but are not managed by Terraform"
}
