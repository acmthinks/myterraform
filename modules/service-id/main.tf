
resource "ibm_iam_service_id" "service_id" {
  name        = join(" ", [upper(var.prefix),"SERVICE_ID"])
  description = join(" ", ["Automatically created SERVICE_ID for", upper(var.prefix)]) 
}

###############################################################################
## Associate a Service ID to Resource Group
#################################################################################
resource "ibm_iam_service_policy" "service_id_policy" {
  iam_service_id  = ibm_iam_service_id.service_id.id
  roles           = var.roles

  resources {
    resource_type = "resource-group"
    resource      = var.resource_group_id
  }
}

###############################################################################
## Add Users to the Access Group (Members)
## 
###############################################################################
resource "ibm_iam_access_group_members" "group_members" {
   access_group_id = var.access_group_id
   iam_service_ids = [ibm_iam_service_id.service_id.id]
}