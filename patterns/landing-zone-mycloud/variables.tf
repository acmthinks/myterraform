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

variable "prefix" {
  type = string
}

variable "sre_members" {
  type    = list(string)
  default = ["acm@us.ibm.com"]
}

variable "audit_members" {
  type    = list(string)
  default = ["acm@us.ibm.com"]
}

variable "dev_members" {
  type    = list(string)
  default = ["acm@us.ibm.com"]
}

variable "ssh_key" {
  type    = string
  default = "andrea-ssh-key"
  description = "Name of ssh key (i.e. 'my_ssh_key' to create a VSI with. SSH key must be in the SAME region as the VSI"
}
