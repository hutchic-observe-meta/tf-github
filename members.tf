variable "members" {
  description = "GitHub users and their roles"
  default = {
    "hutchic"     = "member" # member of the organization or organization admin
    "colinh-kong" = "member"
  }
}

variable "parent_teams" {
  description = "Parent team configuration"
  default = {
    "engineering" = {
      "description" = "Engineering team"
      "privacy"     = "closed"
    }
  }
}

variable "teams" {
  description = "Team configurations"
  default = {
    "integrations" = {
      "description" = "Integrations subteam"
      "privacy"     = "closed"
      "parent_team" = "engineering"
      "members" = {
        "hutchic"     = { role = "member" }
        "colinh-kong" = { role = "member" }
        // ... other integrations team members
      }
    }
    "frontend" = {
      "description" = "Frontend subteam"
      "privacy"     = "closed"
      "parent_team" = "engineering"
      "members" = {
        "colinh-kong" = { role = "member" }
        // ... other frontend team members
      }
    }
  }
}
