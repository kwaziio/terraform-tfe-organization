#############################################################
# Provides Information for Resources Created by this Module #
#############################################################

output "info" {
  description = "Standardized Information for Resources Created by this Module"

  value = {
    admins      = tfe_team_organization_members.admins
    email       = tfe_organization.main.email
    engineers   = tfe_team_organization_members.engineers
    memberships = tfe_organization_memberships.all
    name        = tfe_organization.main.name
    token       = tfe_organization_token.main.token
  }
}
