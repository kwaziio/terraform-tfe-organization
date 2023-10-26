###########################
# Terraform Configuration #
###########################

terraform {
  required_version = ">= 1.6.1"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.49"
    }
  }
}

#################################
# Terraform Cloud Configuration #
#################################

provider "tfe" {
  // DO NOT HARDCODE CREDENTIALS (Use Environment Variables)
  hostname     = "app.terraform.io"
  organization = var.organization_name
}

#####################################################
# Example Terraform Cloud Organization Module Usage #
#####################################################

module "terraform_aws_network" {
  source = "../../"

  organization_email = "example@example.com"
  organization_name  = "example-organization"

  organization_members = [
    // DO NOT INCLUDE INITIAL USER ACCOUNT (OWNER)
  ]

  team_admins = [
    // Add Active Organization Members w/ Administrative Permissions (Email Address)
  ]

  team_engineers = [
    // Add Active Organization Members w/ Power User Permissions (Email Address)
  ]
}
