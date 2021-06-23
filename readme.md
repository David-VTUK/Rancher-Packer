[![Build](https://github.com/David-VTUK/Rancher-Packer/actions/workflows/main.yml/badge.svg)](https://github.com/David-VTUK/Rancher-Packer/actions/workflows/main.yml)

# Packer Templates for Rancher

This repo contains Packer templates suitable to create RKE VM's for a number of IaaS providers. These can be used as-is or used as a basis for further customisation

## How to use

* Clone the repo
* Rename `variables.json.example` to `variables.json`
* Populate `variables.json` with information specific to your environment
* Build with the template and variables files. For example : `packer build -var-file=variables.json ubuntu-18.json` 

## Current Templates

### vSphere

| OS            | Version       | Base Install Script                             | Additional Install Script Variants |
| -----------   | ----------- | ------------------------------------------------| -------------------------------------|
| Centos        | 7           | [Link](/vSphere/centos_7/script.sh)             | None                                                                                    |
| OpenSuse Leap | 15.2        | [Link](/vSphere/opensuse_leap_15.2/install.sh)  | None                                                                                    |
| OpenSuse Leap | 15.3        | [Link](/vSphere/opensuse_leap_15.3/install.sh)  | None                                                                                    |
| RHEL          | 7           | [Link](/vSphere/rhel_7/script.sh)               | None                                                                                    |
| RHEL          | 8           | [Link](/vSphere/rhel_8/script.sh)               | None                                                                                    |
| SLES          | 15 SP 2     | [Link](/vSphere/sles_15_sp2/install.sh)         | None                                                                                    |
| Ubuntu        | 18.04       | [Link](/vSphere/ubuntu_1804/script.sh)          | [Disable DHCP](/vSphere/ubuntu_1804/customisation_scripts/script-no-dhcp.sh)            |
| Ubuntu        | 20.04       | [Link](/vSphere/ubuntu_2004/script.sh))         | [Guestinfo OVF](/vSphere/ubuntu_2004/customisation_scripts/script-cloudinit-guestinfo.sh)|
|               |             |                                                 | [Longhorn](/vSphere/ubuntu_2004/customisation_scripts/script-longhorn.sh)            |
## To do

* CentOS 8
