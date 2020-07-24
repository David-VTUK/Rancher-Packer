# Apply updates and cleanup Apt cache
#
apt-get update ; apt-get -y dist-upgrade
apt-get -y autoremove
apt-get -y clean

# Create a swapfile
#
fallocate -l 2G /.swap
chmod 0600 /.swap
mkswap /.swap
echo '/.swap    swap    swap    default    0   0' >> /etc/fstab

# Reset the machine-id value. This has known to cause issues with DHCP
#
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Reset any existing cloud-init state
#
cloud-init clean -s -l

