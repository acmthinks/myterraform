output "resource_group_id" {
  value = module.resource_group.id
}

output "access_group_admin_id" {
  value = module.access_admin_group.id
}

#output "access_group_sre_id" {
#  value = ibm_resource_group.access_sre_group.id
#}

#output "access_group_audit_id" {
#  value = module.access_audit_group.id
#}

#output "access_group_user_id" {
#  value = module.access_user_group.id
#}
