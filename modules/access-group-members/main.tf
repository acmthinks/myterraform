#######################################################
# Create access group
#######################################################
resource "ibm_iam_access_group" "accgroup" {
   name = join("-", [upper(var.prefix),upper(var.group-type),"MEMBERS"])
   description = var.description
   tags = ["schematics", var.group-type]
}

#######################################################
# Add Users (and Service IDs) to Access Group 
#######################################################
resource "ibm_iam_access_group_members" "accgroupmembers" {
   access_group_id = ibm_iam_access_group.accgroup.id
   ibm_ids = var.members
}
