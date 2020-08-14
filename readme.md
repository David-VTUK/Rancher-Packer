# Packer Templates for Rancher

This repo contains Packer templates suitable to create RKE VM's for a number of IaaS providers. These can be used as-is or used as a basis for further customisation

## How to use

* Clone the repo
* Rename `variables.json.example` to `variables.json`
* Populate `variables.json` with information specific to your environment
* Build with the template and variables files. For example : `packer build -var-file=variables.json ubuntu-18.json` 

## Current Templates

### vSphere

[Ubuntu 18.04](https://github.com/David-VTUK/Rancher-Packer/tree/master/vSphere/ubuntu_1804) - Includes logic to address cloud-init depedency and resolves DHCP issues (cloned VM's receiving the same DHCP address.)

[Ubuntu 18.04 - No DHCP](https://github.com/David-VTUK/Rancher-Packer/tree/master/vSphere/ubuntu_1804_no_dhcp) - Forces not to accept DHCP. 

[Ubuntu 20.04](https://github.com/David-VTUK/Rancher-Packer/tree/master/vSphere/ubuntu_2004)

[Ubuntu 20.04 - With cloud-init & OVF integration](https://github.com/David-VTUK/Rancher-Packer/tree/master/vSphere/ubuntu_2004_cloud_init_guestinfo)

[CentOS 7](https://github.com/David-VTUK/Rancher-Packer/tree/master/vSphere/centos_7)

[RHEL7](https://github.com/David-VTUK/Rancher-Packer/tree/master/vSphere/rhel_7)

[RHEL8](https://github.com/David-VTUK/Rancher-Packer/tree/master/vSphere/rhel_8)


## To do

* CentOS 8
