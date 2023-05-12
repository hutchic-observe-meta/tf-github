# Avaialble repository roles are read, triage, write, maintain and admin
variable "managed_repositories" {
  description = "List of repositories to be managed by Terraform"
  type = map(object({
    teams = map(string)
  }))
  default = {
    "testing" = {
      teams = {
        "observe-employees" = "read",
        "integrations"      = "write"
      }
    }
    // Add more repositories as needed...
  }
}
