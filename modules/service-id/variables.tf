variable "ibmcloud_api_key" {
   description = "API Key or Service ID can be used"
}

variable "region" {
   default = "us-south"
   type = string
   description = "IBM Cloud region to run in."
}
 
variable "prefix" {
   default = "default"
   type = string
   description = "Prefix used to name service id."
}


## These variable inputs are NOT exposed in the Schematics interface
## Instead they are passed from the main.tf to this module
 variable "description" {
   type=string
   description = "Description of Access Group"
}

variable "roles" {
   type=list(string)
   description = "List of roles ['role1', 'role2']"
   default = ["Viewer"]
}

variable "resource_group_id" {
   type=string
   description = "Resource Group id associated with the Service ID"
}

variable "access_group_id" {
   type=string
   description = "Access Group id associated with the Service ID"
}
