#############################################
# Creates Terraform Cloud Main Organization #
#############################################

resource "tfe_organization" "main" {
  allow_force_delete_workspaces = false
  assessments_enforced          = var.organization_enable_global_drift_detection
  collaborator_auth_policy      = var.organization_require_two_factor ? "two_factor_mandatory" : "password"
  cost_estimation_enabled       = true
  email                         = var.organization_email
  name                          = var.organization_name
  session_remember_minutes      = var.organization_session_max
  session_timeout_minutes       = var.organization_session_timeout
}

##################################################
# Creates Organization Memberships for All Users #
##################################################

resource "tfe_organization_membership" "all" {
  count        = length(var.organization_members)
  email        = var.organization_members[count.index]
  organization = tfe_organization.main.name
}

#####################################################
# Creates a Terraform Cloud Team for Administrators #
#####################################################

resource "tfe_team" "admins" {
  name         = "admins"
  organization = tfe_organization.main.name

  organization_access {
    manage_membership       = true
    manage_modules          = true
    manage_policies         = true
    manage_policy_overrides = true
    manage_projects         = true
    manage_providers        = true
    manage_vcs_settings     = true
    manage_workspaces       = true
    read_projects           = true
    read_workspaces         = true
  }
}

###################################################
# Updates Team Memberships for the Administrators #
###################################################

data "tfe_organization_membership" "admins" {
  count        = length(var.team_admins)
  email        = var.team_admins[count.index]
  organization = tfe_organization.main.name
}

resource "tfe_team_organization_members" "admins" {
  count                       = length(data.tfe_organization_membership.admins) > 0 ? 1 : 0
  organization_membership_ids = data.tfe_organization_membership.admins.*.id
  team_id                     = tfe_team.admins.id
}

################################################
# Creates a Terraform Cloud Team for Engineers #
################################################

resource "tfe_team" "engineers" {
  name         = "engineers"
  organization = tfe_organization.main.name

  organization_access {
    manage_membership       = false
    manage_modules          = true
    manage_policies         = false
    manage_policy_overrides = false
    manage_projects         = false
    manage_providers        = true
    manage_vcs_settings     = false
    manage_workspaces       = false
    read_projects           = true
    read_workspaces         = true
  }
}

##############################################
# Updates Team Memberships for the Engineers #
##############################################

data "tfe_organization_membership" "engineers" {
  count        = length(var.team_engineers)
  email        = var.team_engineers[count.index]
  organization = tfe_organization.main.name
}

resource "tfe_team_organization_members" "engineers" {
  count                       = length(data.tfe_organization_membership.engineers) > 0 ? 1 : 0
  organization_membership_ids = data.tfe_organization_membership.engineers.*.id
  team_id                     = tfe_team.engineers.id
}
