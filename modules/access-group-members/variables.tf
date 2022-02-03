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
   description = "Prefix used to name access group."
}


## These variable inputs are NOT exposed in the Schematics interface
## Instead they are passed from the main.tf to this module
variable "group-type" {
   default = "user"
   type=string
   description = "Type of group (i.e., Admin, Ops, Dev, Audit)"
}
 
 variable "description" {
   type=string
   description = "Description of Access Group"
}
 
 variable "members" {
   type=list(string)
   default=["aaa@us.ibm.com"]
   description = "List of members"
}
 
 variable "service_id" {
   type=bool
   default=true
   description = "Indicates whether to create a Service ID"
}
 