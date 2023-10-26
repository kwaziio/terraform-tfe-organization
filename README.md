# Terraform Cloud Organization Module by KWAZI

Terraform Module for Managing the Core Configuration for a Terraform Cloud Organization

## Getting Started

Before attempting to use this module, we recommend ensuring that you've completed the following:

1. Experience with Terraform
1. Downloaded and Installed the Terraform CLI
1. Created an Account on HashiCorp Cloud Platform (HCP)
1. Created an Organization on HashiCorp Cloud Platform (HCP)
1. Updated Default Project Information (Module Requires Standard Features)
1. Created a Terraform Cloud Account
1. Created a User Access Token on Terraform Cloud
1. Created an Empty (New) Organization on Terraform Cloud
1. Upgraded from "Free" to "Standard" Plan on Terraform Cloud

> NOTE: Need help getting to this point? We're here to help! [Check us out at our website](https://www.kwazi.io).

### Writing the Terraform Configuration

The easiest way to get started with this module is to create a `main.tf` file with the following configuration options:

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

> NOTE: You've probably noticed that there are two provider definitions for Terraform Cloud. That's because we use the first (aliased "initial") to create an Organization API Key, then we use the value of that key to initialize the second provider.

### Importing the Terraform Cloud Organization

Before attempting to execute this module, you'll want to import the organization you created manually:

```SHELL
terraform import module.terraform_aws_network.tfe_organization.main ORGANIZATION_NAME
```

In the example above, you should replace the following templated values:

Placeholder | Description
--- | ---
`ORGANIZATION_NAME` | Replace this w/ the Organization's Name

## Need Help?

Working in a strict environment? Struggling to make design decisions you feel comfortable with? Want help from an expert that you can rely on -- one who won't abandon you when the job is finished?

Check us out at [https://www.kwazi.io](https://www.kwazi.io).

## Major Created Resources

The following table lists resources that this module may create in AWS, accompanied by conditions for when they will or will not be created:

Resource Name | Creation Condition
--- | ---
Organization | Always
Organization Token | Always
Organization Memberships | When `organization_members` Includes a List of Email Addresses
Team for Administration | Always
Team for Power Users (Engineers) | Always
Team Member Associations | When `team_admins` or `team_engineers` Include a List of Email Addresses

## Usage Examples

The following examples are provided as guidance:

* [examples/standard](examples/standard/README.md)
