###############################################################################
## Create a Resource Group 
##
## This calls a module that takes a naming "prefix" and appends "-rg" to a 
## Resource Group
## This Resource Group is referred to in this script as module.resource_group
###############################################################################
module "resource_group" {
  source = "../../modules/resource-group"

  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  prefix           = var.prefix
}


###############################################################################
## Create an Admin Service ID (optional)
##
## This uses a module that takes a naming "prefix" and creates a Service ID
## which will be added to the Access Group
## This Resource Group is referred to in this script as module.admin_service_id
##
###############################################################################
module "admin_service_id" {
  source = "../../modules/service-id"

  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  prefix           = join (" ", [var.prefix, "Admin"])
  roles            = ["Administrator"]
  resource_group_id= module.resource_group.id
  access_group_id  = module.access_admin_group.id
  description      = join(" ", ["ADMIN Service ID for", module.resource_group.name])
}

###############################################################################
## Create an SRE Service ID (optional)
##
## This uses a module that takes a naming "prefix" and creates a Service ID
## which will be added to the Access Group
## This Resource Group is referred to in this script as module.sre_service_id
## 
###############################################################################
module "sre_service_id" {
  source = "../../modules/service-id"

  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  prefix           = join (" ", [var.prefix, "SRE"])
  roles            = ["Operator"]
  resource_group_id= module.resource_group.id
  access_group_id  = module.access_sre_group.id
  description      = join(" ", ["SRE Service ID for", module.resource_group.name])
}

###############################################################################
## Create an Audit Service ID (optional)
##
## This uses a module that takes a naming "prefix" and creates a Service ID
## which will be added to the Access Group
## This Resource Group is referred to in this script as module.audit_service_id
##
###############################################################################
module "audit_service_id" {
  source = "../../modules/service-id"

  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  prefix           = join (" ", [var.prefix, "Audit"])
  roles            = ["Viewer"]
  resource_group_id= module.resource_group.id
  access_group_id  = module.access_audit_group.id
  description      = join(" ", ["AUDIT Service ID for", module.resource_group.name])
}

###############################################################################
## Create an Users Service ID (optional)
##
## This uses a module that takes a naming "prefix" and creates a Service ID
## which will be added to the Access Group
## This Resource Group is referred to in this script as module.users_service_id
##
###############################################################################
module "dev_service_id" {
  source = "../../modules/service-id"

  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  prefix           = join (" ", [var.prefix, "Dev"])
  roles            = ["Editor"]
  resource_group_id= module.resource_group.id
  access_group_id  = module.access_user_group.id
  description      = join(" ", ["Dev Service ID for", module.resource_group.name])
}

##
##            ADMIN Access Group
##

###############################################################################
## Create an Access Group (Administrators)
##
## This uses a module that takes a naming "prefix" and an access "group-type"
## This Access Group is referred to in this script as module.access_admin_group
###############################################################################
module "access_admin_group" {
  source = "../../modules/access-group"

  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  prefix           = var.prefix
  group-type       = "admin"
  members          = var.admin_members
  description      = join(" ", ["Administrator access group for", module.resource_group.name])
}

###############################################################################
## Set Access Group Policies (default, Administrators)
##
## Grants "Editor" and "Manager" roles (and privileges) to the access group
## and associates the Access Group to the Resource Group created in Step 1.
## This Policy is referred to in this script as module.admin_default_policy
## https://cloud.ibm.com/docs/account?topic=account-iam-service-roles-actions
###############################################################################
resource "ibm_iam_access_group_policy" "admin_default_policy" {
   access_group_id = module.access_admin_group.id
   roles = ["Editor", "Manager"]

   resources {
     resource_group_id = module.resource_group.id
   }
}

###############################################################################
## Set Access Group Policies for Resource Group (default, Administrators)
##
## Grants "Viewer" roles (and privileges) to the access group and associates with
## the Resource Group created in Step 1. This is a special role that is needed 
## to be able to view/discover the Resource Group. It is an additive role.
## This Policy is referred to in this script as module.admin_resource_group_policy
###############################################################################
resource "ibm_iam_access_group_policy" "admin_resource_group_policy" {
   access_group_id = module.access_admin_group.id
   roles =  ["Viewer"]
   
   resources  {
     resource_type = "resource-group"
     resource = module.resource_group.id
  }
}

###############################################################################
## Add Users to the Access Group (Administrator Members)
## 
###############################################################################
resource "ibm_iam_access_group_members" "admin_group_members" {
   access_group_id = module.access_admin_group.id
   ibm_ids       =  var.admin_members
}



##
##            SRE Access Group
##

###############################################################################
## 3a. Create an Access Group (SRE)
## This uses a module that takes a naming "prefix" and an access "group-type"
## This Access Group is referred to in this script as module.access_sre_group
###############################################################################
module "access_sre_group" {
  source = "../../modules/access-group"

  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  prefix           = var.prefix
  group-type       = "sre"
  description      = join(" ", ["SRE access group for", module.resource_group.name])
  members          = var.sre_members
}

###############################################################################
## Add Users to the Access Group (Administrator Members)
## 
###############################################################################
#resource "ibm_iam_access_group_members" "admin_group_members" {
#   access_group_id = module.access_admin_group.id
#   ibm_ids       =  var.sre_members
#}

##
##            AUDIT Access Group
##

###############################################################################
## 3a. Create an Access Group (Audit)
## This uses a module that takes a naming "prefix" and an access "group-type"
## This Access Group is referred to in this script as module.access_audit_group
###############################################################################
module "access_audit_group" {
  source = "../../modules/access-group"

  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  prefix           = var.prefix
  group-type       = "audit"
  description      = join(" ", ["Audit access group for", module.resource_group.name])
  members          = var.audit_members
}



##
##            USER Access Group
##

###############################################################################
## 3a. Create an Access Group (Users)
## This uses a module that takes a naming "prefix" and an access "group-type"
## This Access Group is referred to in this script as module.access_user_group
###############################################################################
module "access_dev_group" {
  source = "../../modules/access-group"

  region           = var.region
  ibmcloud_api_key = var.ibmcloud_api_key
  prefix           = var.prefix
  group-type       = "Dev"
  description      = join(" ", ["Dev access group for", module.resource_group.name])
  members          = var.dev_members
}

###############################################################################
## 2b. Set Access Group Policies (default, Users)
## Grants roles (and privileges) to the access group and associates the Access 
## Group to the Resource Group created in Step 1.
## This Policy is referred to in this script as module.user_default_policy
##
## This is Access Group can be used by the dev team, so we'll give some basic
## roles to get started.
## https://cloud.ibm.com/docs/account?topic=account-iam-service-roles-actions
###############################################################################
resource "ibm_iam_access_group_policy" "user_default_policy" {
   access_group_id = module.access_dev_group.id
   roles = ["Editor"]
   resources {
     resource_group_id = module.resource_group.id
   }
}

resource "ibm_iam_access_group_policy" "user_containers-kubernetes_policy" {
   access_group_id = module.access_dev_group.id
   roles = ["Editor"]
   resources {
     service           = "containers-kubernetes"
     resource_group_id = module.resource_group.id
   }
}

resource "ibm_iam_access_group_policy" "user_continuous-delivery_policy" {
   access_group_id = module.access_dev_group.id
   roles = ["Editor"]
   resources {
     service           = "continuous-delivery"
     resource_group_id = module.resource_group.id
   }
}

resource "ibm_iam_access_group_policy" "user_toolchain_policy" {
   access_group_id = module.access_dev_group.id
   roles = ["Editor"]
   resources {
     service           = "toolchain"
     resource_group_id = module.resource_group.id
   }
}

resource "ibm_iam_access_group_policy" "user_codeengine_policy" {
   access_group_id = module.access_dev_group.id
   roles = ["Editor"]   
   resources {
     service           = "codeengine"
     resource_group_id = module.resource_group.id
   }
}

resource "ibm_iam_access_group_policy" "user_cloudantnosqldb_policy" {
   access_group_id = module.access_dev_group.id
   roles = ["Editor"]   
   resources {
     service           = "cloudantnosqldb"
     resource_group_id = module.resource_group.id
   }
}

resource "ibm_iam_access_group_policy" "user_appid_policy" {
   access_group_id = module.access_dev_group.id
   roles = ["Editor"]
   resources {
     service           = "appid"
     resource_group_id = module.resource_group.id
   }
}

resource "ibm_iam_access_group_policy" "user_logdnaat_policy" {
   access_group_id = module.aaccess_dev_group.id
   roles = ["Editor"]   
   resources {
     service           = "logdnaat"
     resource_group_id = module.resource_group.id
   }
}

resource "ibm_iam_access_group_policy" "user_secrets-manager_policy" {
   access_group_id = module.access_dev_group.id
   roles = ["Editor"]
   resources {
     service           = "secrets-manager"
     resource_group_id = module.resource_group.id
   }
}
