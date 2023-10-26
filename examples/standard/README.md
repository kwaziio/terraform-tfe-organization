
# Standard Usage Example

This example is intended to show a standard use case for this module.

```HCL
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
  alias        = "initial"
  hostname     = "app.terraform.io"
  organization = var.organization_name
}

provider "tfe" {
  // DO NOT HARDCODE CREDENTIALS (Use Environment Variables)
  hostname     = "app.terraform.io"
  organization = var.organization_name
  token        = tfe_organization_token.main.token
}

#####################################################
# Example Terraform Cloud Organization Module Usage #
#####################################################

module "terraform_aws_network" {
  source = "../../"

  organization_email = "ORGANIZATION_EMAIL"
  organization_name  = "ORGANIZATION_NAME"

  organization_members =[
    // DO NOT INCLUDE INITIAL USER ACCOUNT (OWNER)
    "MEMBER_EMAIL_ADDRESS",
  ]

  team_admins =[
    // Add Active Organization Members w/ Administrative Permissions (Email Address)
    "MEMBER_EMAIL_ADDRESS",
  ]

  team_engineers =[
    // Add Active Organization Members w/ Power User Permissions (Email Address)
    "MEMBER_EMAIL_ADDRESS",
  ]
}
```

In the example above, you should replace the following templated values:

Placeholder | Description
--- | ---
`MEMBER_EMAIL_ADDRESS` | Replace this w/ Zero-to-Many Non-Owner Email Addresses
`ORGANIZATION_EMAIL` | Replace this w/ the Organization's Email Address
`ORGANIZATION_NAME` | Replace this w/ the Organization's Name
