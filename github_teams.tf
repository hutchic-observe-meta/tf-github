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
