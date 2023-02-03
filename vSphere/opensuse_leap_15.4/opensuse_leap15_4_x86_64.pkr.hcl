
variable "cluster" {
  type    = string
}

variable "datastore" {
  type    = string
}

variable "folder" {
  type    = string
}

variable "network" {
  type    = string
}

variable "password" {
  type    = string
}

variable "ssh_password" {
  type    = string
}

variable "ssh_username" {
  type    = string
}

variable "vcenter_server" {
  type    = string
}

variable "host" {
  type    = string
}

variable "iso_url" {
  type    = string
}

variable "iso_checksum" {
  type    = string
}

variable "cpus" {
  type    = number
}

variable "cores" {
  type    = number
}

variable "ram" {
  type    = number
}

variable "disk0_size" {
  type    = number
}

variable "disk1_size" {
  type    = number
}

variable "vm_name" {
  type    = string
}

#
# LOCALS
#

locals {
  buildtime = formatdate("YYYY-MM-DD", timestamp())
}

source "vsphere-iso" "opensuse_goldenimage" {
  boot_command         = ["<esc><enter><wait>", "linux ", "biosdevname=0 ", "net.ifnames=0 ", "netdevice=eth0 ", "netsetup=dhcp ", "lang=en_US ", "textmode=1 ", "autoyast=device://fd0/autoinst.xml", "<enter><wait>"]
  boot_wait            = "5s"
  cluster              = "${var.cluster}"
  convert_to_template  = "true"
  CPUs                 = "${var.cpus}"
  cpu_cores            = "${var.cores}"
  firmware             = "bios"
  datastore            = "${var.datastore}"
  floppy_files         = ["./autoinst.xml"]
  folder               = "${var.folder}"
  guest_os_type        = "sles15_64Guest"
  host                 = "${var.host}"
  insecure_connection  = "true"
  iso_checksum         = "${var.iso_checksum}"
  iso_url             = "${var.iso_url}"
  password        = "${var.password}"
  RAM             = "${var.ram}"
  RAM_reserve_all = true
  ssh_password    = "${var.ssh_password}"
  ssh_port        = 22
  ssh_timeout     = "10000s"
  ssh_username    = "${var.ssh_username}"
  disk_controller_type    = ["pvscsi"]
  storage {
    disk_size             = "${var.disk0_size}"
    disk_controller_index = 0
    disk_thin_provisioned = true
  }
  storage {
    disk_size             = "${var.disk1_size}"
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = "${var.network}"
    network_card = "vmxnet3"
  }
  
  username       = "${var.username}"
  vcenter_server = "${var.vcenter_server}"
  vm_name        = "${var.vm_name}-${local.buildtime}"
}

build {
  sources = ["source.vsphere-iso.opensuse_goldenimage"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | sudo -S -E bash '{{ .Path }}'"
    scripts         = ["install.sh"]
    expect_disconnect = true
  }
}
