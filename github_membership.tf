resource "github_membership" "organization_members" {
  for_each = var.members

  username = each.key
  role     = each.value
}

resource "github_team_membership" "team_members" {
  for_each = merge([
    for team, config in var.teams : {
      for member, member_config in config.members : "${member}:${team}" => {
        "team" = team
        "role" = member_config.role
      }
    }
  ]...)

  team_id  = github_team.teams[each.value.team].id
  username = split(":", each.key)[0]
  role     = each.value.role
}

resource "github_team_membership" "parent_team_members" {
  for_each = merge([
    for team, config in var.parent_teams : {
      for member, member_config in config.members : "${member}:${team}" => {
        "team" = team
        "role" = member_config.role
      }
    }
  ]...)

  team_id  = github_team.parent_teams[each.value.team].id
  username = split(":", each.key)[0]
  role     = each.value.role
}

# Fetch all organization members
data "github_organization" "org_info" {
  name = var.github_organization
}

# Define all managed organization members
locals {
  managed_org_members = keys(var.members)
}

# Define unmanaged organization members
locals {
  unmanaged_org_members = [for user in data.github_organization.org_info.users : user.login if !contains(local.managed_org_members, user.login)]
}

# Output the list of unmanaged organization members
output "unmanaged_org_members" {
  value       = [for member in local.unmanaged_org_members : "The member ${member} is not managed by Terraform."]
  description = "List of organization members that exist on GitHub but are not managed by Terraform"
}
