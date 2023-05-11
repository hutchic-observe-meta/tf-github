variable "members" {
    description = "GitHub users and their roles"
    default = {
        "hutchic" = "member" # member of the organization or organization admin
        "colinh-kong" = "member"
    }
}

variable "engineering_team_members" {
  description = "Members of the engineering team"
  default = {
    "hutchic" = "member"
    "colinh-kong" = "member"
  }
}

variable "integrations_team_members" {
    description = "Members of the integrations subteam"
    default = {
        "hutchic" = "maintainer"
        "colinh-kong" = "member"
    }
}

variable "frontend_team_members" {
    description = "members of the frontend subteam"
    default = {
        "colinh-kong" = "member"
    }
}
