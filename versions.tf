terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_organization
}
