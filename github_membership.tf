resource "github_membership" "colinhutchinson" {
  username = "hutchic"
  role     = "member"
}

resource "github_team" "integrations" {
  name = "integrations"
  description = "Integrations team"
  privacy = "closed"
}

resource "github_team_membership" "integrations_team_membership" {
  team_id = github_team.integrations.id
  username = github_membership.colinhutchinson.username
  role = "member"
}
