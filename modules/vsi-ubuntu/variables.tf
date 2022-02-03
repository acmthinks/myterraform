variable "ibmcloud_api_key" {
   //default = ""
}

variable "region" {
   default = "us-south"
   description = "Region.  Must be same Region as the VPC"
}

variable "zone" {
   default = "us-south-1"
   description = "Zone in which to provision the VSI.  Must be in the same Region as the VPC."
}

variable "resource_group_id" {
//  default = ""
   description = "ID of Resource Group in which to provision the VSI. "
}

variable "vpc_id" {
//  default = ""
   description = "ID of VPC into which to provision the VSI.  A subnet will also be created."
}

variable "basename" {
//  default = ""
   description = "Prefix used to name all resources."
}

variable "ssh_key" {
   #default = "andrea-ssh-key"
   description = "ID of SSH Key already provisioned in the region. This will be used to access the VSI."
}

variable "image_id" {
   default = "ibm-ubuntu-20-04-3-minimal-amd64-1"
   description = "ID of image. To get a list of current images, issue 'ibmcloud is images | grep ubuntu' on the 'ibmcloud' CLI."
}

variable "image_profile" {
   default = "bx2-2x8"
   description = "Profile (of resources) on image. To get a list of current images, issue 'ibmcloud is images | grep ubuntu' on the 'ibmcloud' CLI."
}
