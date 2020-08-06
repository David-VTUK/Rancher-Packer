#!/bin/bash

# purge files to make sure since we are going to recreate them
rm /etc/rhsm/facts/katello.facts
rm /etc/yum.repos.d/docker.repo
rm /etc/environment
rm /etc/systemd/system/docker.service.d/https-proxy.conf
rm /etc/profile.d/proxy.sh

# Proxy stuff
cat <<EOT >> /etc/profile.d/proxy.sh
export HTTP_PROXY=http://<<proxy_server>>:8080
export HTTPS_PROXY=http://<<proxy_server>>:8080
export http_proxy=http://<<proxy_server>>:8080
export https_proxy=http://<<proxy_server>>:8080
EOT

cat <<EOT >> /etc/environment
http_proxy=http://<<proxy_server>>:8080
https_proxy=http://<<proxy_server>>:8080
HTTP_PROXY=http://<<proxy_server>>:8080
HTTPS_PROXY=http://<<proxy_server>>:8080
EOT

mkdir /etc/systemd/system/docker.service.d
cat <<EOT >> /etc/systemd/system/docker.service.d/https-proxy.conf
[Service]
Environment="HTTP_PROXY=http://<<proxy_server>>:8080/"
Environment="HTTPS_PROXY=http://<<proxy_server>>:8080/"
Environment="NO_PROXY=<<rancher_url>>,127.0.0.0/8,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
EOT

# Do subscription manager stuff and update packages
cat <<EOT >> /etc/rhsm/facts/katello.facts
{"network.hostname-override":"<<yourdomain>>.local"}
EOT

rpm -Uvh http://<<your_rsat_server>>/pub/katello-ca-consumer-latest.noarch.rpm
subscription-manager register --org="<<org_name>>" --activationkey='<<activation_key>>'
subscription-manager repos --enable=rhel-8-for-x86_64-appstream-rpms
yum -y install vim nano net-tools bind-utils
yum -y update

cat <<EOT >> /etc/yum.repos.d/docker.repo
[docker-ce-stable]
name=Docker CE Stable - $basearch
baseurl=http://<<your_repo_server>>/docker-ce-stable-upstream/
failovermethod=priority
enabled=1
gpgcheck=0
EOT

yum clean packages
yum clean metadata
yum clean all

yum -y install container-selinux
#The upstream has an issue where containerd.io is hidden from the system in dnf
#yum -y install containerd.io
yum -y --disablerepo="*" --enablerepo=docker-ce-stable install http://<<your_repo_server>>/docker-ce-stable/Packages/containerd.io-1.2.13-3.2.el7.x86_64.rpm
yum -y install docker-ce docker-ce-selinux
systemctl daemon-reload
service docker restart
systemctl enable docker

subscription-manager unregister

docker run hello-world
docker rm $(docker ps -a -f status=exited -f status=created -q)
docker rmi $(docker images -a -q)

# Reset the machine-id value. This has known to cause issues with DHCP
#
echo -n > /etc/machine-id

# Reset any existing cloud-init state
#
cloud-init clean -s -l

