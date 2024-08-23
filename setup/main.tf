module "vm-create" {
  source = "../create-vm"
  vsphere_server   = ""
  vsphere_user     = ""
  vsphere_password = ""

  datacenter       = "DatacenterDEV"
  datastore        = {
    "0"            = "ESXiTest131_dbs"
#    "1"            = "datastore1 (6)"
  }

  cluster          = {
    "0"            = "Vm-Cluster-Blade"
#    "1"            = "Vm-Cluster-test01"
  }

  network_name     = "VM Network"

  guest_template   = "Ubuntu22_Temp08062024"
  guest_vcpu       = "4"
  guest_memmory    = "4096"
  guest_disk       = "50"
  guest_dns_server = ""
  guest_gateway    = ""

  guest_vm_name    = {
    "0" = "tp-monitor"
#    "1" = "ubuntu-terraform-test02"
  }

  guest_host_name  = {
    "0" = "telegraf-prometheus"
#    "1" = "kworker02"
  }

  guest_domain_name = "ubuntu"
  user_vm          = "root"
  password_vm      = "1234"

  ip_vm = {
    "0" = ""
#    "1" = ""
  }
}
