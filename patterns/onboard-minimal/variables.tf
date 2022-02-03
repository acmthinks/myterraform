###############################################################################
## Declare variables
##
###############################################################################

variable "ibmcloud_api_key" {
  type = string
}

variable "region" {
  type    = string
  default = "us-south"
}

variable "zone" {
  type    = string
  default = "us-south-1"
}

variable "prefix" {
  type = string
}

variable "admin_members" {
  type    = list(string)
  default = ["aaa@ibm.com"]
}

variable "is_admin_service_id" {
  type    = bool
  default = true
  description = "If true, a Service ID for the ADMIN Access Group will be created"
}

variable "sre_members" {
  type    = list(string)
  default = ["aaa@ibm.com"]
}

variable "is_sre_service_id" {
  type    = bool
  default = false
  description = "If true, a Service ID for the SRE Access Group will be created"
}

variable "audit_members" {
  type    = list(string)
  default = ["aaa@ibm.com"]
}

variable "is_audit_service_id" {
  type    = bool
  default = false
  description = "If true, a Service ID for the AUDIT Access Group will be created"
}

variable "users_members" {
  type    = list(string)
  default = ["aaa@ibm.com"]
}

variable "is_users_service_id" {
  type    = bool
  default = true
  description = "If true, a Service ID for the USERS Access Group will be created"
}

variable "ssh_key" {
  type    = string
  default = "andrea-ssh-key"
  description = "Name of ssh key (i.e. 'my_ssh_key' to create a VSI with. SSH key must be in the SAME region as the VSI"
}
