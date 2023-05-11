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
