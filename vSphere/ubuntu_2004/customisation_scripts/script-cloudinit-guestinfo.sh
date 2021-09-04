# Apply updates and cleanup Apt cache
#
apt-get update ; apt-get -y dist-upgrade
apt-get -y autoremove
apt-get -y clean

# Disable swap - generally recommended for K8s, but otherwise enable it for other workloads
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Reset the machine-id value. This has known to cause issues with DHCP
#
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Reset any existing cloud-init state
#
echo "Resetting Cloud-Init"
rm /etc/cloud/cloud.cfg.d/*.cfg
cloud-init clean -s -l

# Add cloud-init-vmware-guestinfo
#
curl -sSL https://raw.githubusercontent.com/vmware/cloud-init-vmware-guestinfo/master/install.sh | sh -

# Prevent cloud-init from setting IP -- Uncomment below lines if you want static ip setup via vApp Pool
#
# echo "Disabling cloud-init networking"
# bash -c "echo 'network: {config: disabled}' > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg"

# echo "Removing existing Netplan config file"
# rm /etc/netplan/*.yaml
