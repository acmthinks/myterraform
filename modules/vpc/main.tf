resource "ibm_is_vpc" "vpc" {
  name = "${var.basename}-vpc"
  resource_group = var.resource_group_id
  #default_routing_table_name = join("-", [var.basename, "rt", "default"])
  #default_security_group_name = join("-", [var.basename, "sg", "default"])
  #default_network_acl_name = join("-", [var.basename, "acl", "default"])
}

#rename the default routing table with a more meaningful name
#resource "ibm_is_vpc_routing_table" "vpc_routing_table" {
#  vpc = ibm_is_vpc.vpc.id
#  name = join("-", [var.basename, "rt", "default"])
#}

#rename the default security group with a more meaningful name
resource "ibm_is_security_group" "vpc_security_group" {
  vpc = ibm_is_vpc.vpc.id
  name = join("-", [var.basename, "sg", "default"])
}

#rename the default access control list with a more meaningful name
resource "ibm_is_network_acl" "vpc_network_acl" {
  vpc = ibm_is_vpc.vpc.id
  name = join("-", [var.basename, "acl", "default"])
}
