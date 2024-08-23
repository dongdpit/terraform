provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  count         = length(var.datastore)
  name          = lookup(var.datastore, count.index)
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  count         = length(var.cluster)
  name          = lookup(var.cluster, count.index)
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "source_template" {
  name          = var.guest_template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  count            = length(var.ip_vm)
  name             = lookup(var.guest_vm_name, count.index)
  resource_pool_id = data.vsphere_compute_cluster.cluster[count.index].resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore[count.index].id
  num_cpus         = var.guest_vcpu
  memory           = var.guest_memmory
  guest_id         = data.vsphere_virtual_machine.source_template.guest_id
  scsi_type        = data.vsphere_virtual_machine.source_template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.source_template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = var.guest_disk
    thin_provisioned = false
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id

    customize {
      linux_options {
        host_name = lookup(var.guest_host_name, count.index)
        domain    = var.guest_domain_name
      }
      network_interface {
        ipv4_address = lookup(var.ip_vm, count.index)
        ipv4_netmask = 24
        dns_domain   = var.guest_dns_server
      }
      ipv4_gateway = var.guest_gateway
    }
  }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [vsphere_virtual_machine.vm]

  create_duration = "30s"
}

output "vm-complete" {
  value     =  vsphere_virtual_machine.vm[*].guest_ip_addresses
  description  =  "Vm create complete"
}
