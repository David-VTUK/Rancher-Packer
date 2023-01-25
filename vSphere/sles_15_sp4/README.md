# Rancher-suitable Packer build configuration for SLES 15 SP4

Before you use Packer to build this image, you need to do the following:

* Download the SLES 15 SP4 'online' GM ISO (`SLE-15-SP4-Online-x86_64-QU1-Media1.iso`) and drop
  it into this folder;
* Update `autoinstall.xml` and amend line 266 to specify your registration code
  so that various add-ons can be included.

As with the other openSUSE image, you may also want to change the default build user (`packerbuilt`) /
password.
