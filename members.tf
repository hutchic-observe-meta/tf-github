# Available organization roles are member or admin
variable "members" {
  description = "GitHub users and their roles"
  default = {
    "hutchic"     = "member"
    "colinh-kong" = "member"
  }
}

variable "parent_teams" {
  description = "Parent team configuration"
  default = {
    "observe-employees" = {
      "members" = {
        "hutchic"     = { role = "member" }
        "colinh-kong" = { role = "member" }
      }
      "description" = "observe-employees team"
      "privacy"     = "closed"
    }
  }
}

# Available team roles are member or maintainer
variable "teams" {
  description = "Team configurations"
  default = {
    "integrations" = {
      "description" = "Integrations subteam"
      "privacy"     = "closed"
      "parent_team" = "observe-employees"
      "members" = {
        "hutchic"     = { role = "member" }
        "colinh-kong" = { role = "member" }
        // ... other integrations team members
      }
    }
    "frontend" = {
      "description" = "Frontend subteam"
      "privacy"     = "closed"
      "parent_team" = "observe-employees"
      "members" = {
        "colinh-kong" = { role = "member" }
        // ... other frontend team members
      }
    }
  }
}
