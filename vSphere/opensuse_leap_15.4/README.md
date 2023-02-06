# Packer OpenSUSE Leap 15.4 Image in VMware for Rancher RKE2

This packer script will create an OpenSUSE Leap 15.4 Template. tergeted to be a Golden Image for RKE2 deployments.

## The following is handled in the preseed file ```autoinst.xml```

* Swap not implemented.
* Disk-1 as XFS Partition mounted under ```/var/lib/rancher```.
* Installation of cloud-init.
* cloud-init services enablement.

## Create a hashed 512-sha password for the priviledged user

The user ```root``` is employed in the script for simplicity of operations and a hashed password must be provided in the ```autoinst.xml``` file.
To generate a hashed 512-sha password for this user, you can use ```openssl``` as the example below:

```sh
openssl passwd -6
Password: 
Verifying - Password: 
$6$qe3staoHstY7ptxj$.QDw8GgQE.UFUdynEkJPgPdImB//Xu3M58dOXJ.KuE.MURj0D/PxzxWvlLVn4Nfd0woBCphXt2TRxwXwJ/Ltp1
```

## Running packer build with hcl

Rename the ```variables.pkrvar.hcl``` and populate as you see fit.
run the following and enjoy your coffee :)

```sh
packer build -var-file variables.pkrvar.hcl opensuse_leap15_4_x86_64.pkr.hcl
```

## To do

* In file ```install.sh``` there's a dirty hack to wait for 10 minutes (```sleep 600```) after the first boot, to allow YAST2 to complete the installation. The wait prevents the packer from shutting down the VM too soon. 