# Reset the machine-id value. This has known to cause issues with DHCP
echo -n > /etc/machine-id

# Reset any existing cloud-init state
cloud-init clean --logs
