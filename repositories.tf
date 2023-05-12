variable "managed_repositories" {
  description = "List of repositories to be managed by Terraform"
  type = map(object({
    teams = map(string),
    settings = optional(object({
      allow_merge_commit     = optional(bool),
      allow_auto_merge       = optional(bool),
      vulnerability_alerts   = optional(bool),
      delete_branch_on_merge = optional(bool)
    }))
  }))
  default = {
    "testing" = {
      teams = {
        "observe-employees" = "read",
        "integrations"      = "write"
      },
      settings = {
        allow_merge_commit = true
        // You can add other settings here as needed...
      }
    }
    // Add more repositories as needed...
  }
}
