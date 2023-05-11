resource "github_membership" "members" {
  for_each = var.members

  username = each.key
  role     = each.value
}

resource "github_team" "engineering" {
  name        = "engineering"
  description = "Engineering team"
  privacy     = "closed"
}

resource "github_team_membership" "engineering_team" {
  for_each = var.engineering_team_members

  team_id  = github_team.engineering.id
  username = each.key
  role     = each.value
}

resource "github_team" "integrations" {
  name        = "integrations"
  description = "Integrations team"
  privacy     = "closed"
}

resource "github_team_membership" "integrations_team" {
  for_each = var.integrations_team_members

  team_id  = github_team.integrations.id
  username = each.key
  role     = each.value
}

resource "github_team" "frontend" {
  name        = "frontend"
  description = "Frontend team"
  privacy     = "closed"
}

resource "github_team_membership" "frontend_team" {
  for_each = var.frontend_team_members

  team_id  = github_team.frontend.id
  username = each.key
  role     = each.value
}
