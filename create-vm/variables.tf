variable "vsphere_server" {
  description = "This is the vCenter Server FQDN or IP Address for vSphere API operations."
  type        = string
}

variable "vsphere_user" {
  description = "This is the username for vSphere API operations"
  type        = string
  sensitive   = true
}

variable "vsphere_password" {
  description = "This is the password for vSphere API operations"
  type        = string
  sensitive   = true
}

variable "datacenter" {
  description = "The name of the datacenter. This can be a name or path."
  type        = string
}

variable "datastore" {
  description = "The name of the datastore. This can be a name or path."
  type        = map(any)
}

variable "cluster" {
  description = " The name of the cluster"
  type        = map(any)
}

variable "network_name" {
  description = "The name of the network"
  default     = "VM Network"
  type        = string

}

variable "guest_template" {
  description = "Named template use"
  type        = string
}

variable "guest_disk" {
  description = "Storage for Vm"
  type        = number
}

variable "ip_vm" {
  description = "The IPv4 address assigned to the network adapter. If blank or not included, DHCP is used."
  type        = map(any)
}

variable "guest_dns_server" {
  description = "DNS search domain for the network interface"
  type        = string
}

variable "guest_gateway" {
  description = "The IPv4 default gateway when using network_interface customization on the virtual machine."
  type        = string
}

variable "guest_vm_name" {
  description = "The name of the virtual machine. This can be a name or the full path relative to the datacenterue"
  type        = map(any)
}

variable "guest_host_name" {
  description = "The host name for this machine. This, along with domain, make up the FQDN of the virtual machine."
  type        = map(any)
}

variable "user_vm" {
  description = "User of template for copy ssh key"
  type        = string
  sensitive   = true
}

variable "password_vm" {
  description = "Password User for copy ssh key"
  type        = string
  sensitive   = true
}

variable "guest_domain_name" {
  description = "The domain name for this machine. This, along with host_name, make up the FQDN of the virtual machine."
  type        = string
}

variable "guest_vcpu" {
  description = " The total number of virtual processor cores to assign to the virtual machine"
  type        = number
}

variable "guest_memmory" {
  description = "The memory size to assign to the virtual machine, in MB."
  type        = number
}
