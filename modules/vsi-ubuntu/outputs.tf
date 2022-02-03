output "vsi_private_ip" {
  value = ibm_is_instance.vsi.primary_network_interface.0.primary_ipv4_address
}

output "vsi_floating_ip" {
  value = ibm_is_floating_ip.vsi_floatingip.address
}

output "vsi_subnet" {
  value = ibm_is_subnet.subnet_vsi.ipv4_cidr_block
}

output "vsi_security_group_id" {
  value = ibm_is_security_group.vsi_sg.id
}

output "vsi_ssh_inboud_rule_id" {
  value = split(".", ibm_is_security_group_rule.rule-ssh-inbound.id)[1]
}

output "DISABLE_SSH" {
  value = "\nCommand to remove rule that allows inbound ssh:\n ibmcloud is security-group-rule-delete ${ibm_is_security_group.vsi_sg.id} ${split(".", ibm_is_security_group_rule.rule-ssh-inbound.id)[1]}\n"
}