##################################################
# HCP Terraform Cloud Organization Configuration #
##################################################

variable "organization_email" {
  description = "Email Address Associated w/ the Created Organization"
  type        = string
}

variable "organization_enable_global_drift_detection" {
  default     = false
  description = "'true' if Drift Detection for Workspaces Should be Globally Enabled"
  type        = bool
}

variable "organization_members" {
  default     = []
  description = "List of Email Addresses for Organization Members (DO NOT INCLUDE ACCOUNT OWNER)"
  type        = list(string)
}

variable "organization_name" {
  description = "Name Assigned to the Created Organization"
  type        = string
}

variable "organization_require_two_factor" {
  default     = true
  description = "'true' if Organization Collaborators Should be Required to Use Two-Factor Authentication"
  type        = bool
}

variable "organization_session_max" {
  default     = 60
  description = "Maximum Time (in Minutes) Before Reauthentication is Required"
  type        = number
}

variable "organization_session_timeout" {
  default     = 15
  description = "Time (in Minutes) Before User is Forced to Reauthenticate Due to Inactivity"
  type        = number
}

variable "organization_token_expiration" {
  default     = null
  description = "Date and Time (RFC3339 Format) When Organization API Token Should Expire"
  type        = string
}

#######################################################
# HCP Terraform Cloud Organization Team Configuration #
#######################################################

variable "team_admins" {
  default     = []
  description = "List of Organization Members w/ Administrative Permissions (Email Address)"
  type        = list(string)
}

variable "team_engineers" {
  default     = []
  description = "List of Organization Members w/ Power User Permissions (Email Address)"
  type        = list(string)
}
