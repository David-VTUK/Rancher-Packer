# Reset the machine-id value. This has known to cause issues with DHCP
echo -n > /etc/machine-id

# Reset any existing cloud-init state
cloud-init clean --logs

# Force no DHCP usage
echo "network: {config: disabled}" > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg

# Disable IPV6
echo "net.ipv6.conf.all.disable_ipv6=1" > /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6=1" > /etc/sysctl.conf

# Disable Swap
swapoff -a 
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab