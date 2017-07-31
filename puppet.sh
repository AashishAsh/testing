#!/bin/bash

sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
cat puppetlabs.repo
sudo yum-config-manager --enable puppetlabs-devel
cat puppetlabs.repo
sudo yum install -y puppetserver
#To upgrade a Puppet master to the latest version of Puppet 3, run:
sudo puppet resource package puppet-server ensure=latest
sudo timedatectl set-timezone America/New_York
sudo yum -y install ntp
sudo ntpdate pool.ntp.org

echo -e "server 0.us.pool.ntp.org
server 1.us.pool.ntp.org
server 2.us.pool.ntp.org
server 3.us.pool.ntp.org\n$(cat /etc/ntp.conf)" > /etc/ntp.conf 

sudo systemctl restart ntpd
sudo systemctl enable ntpd
sudo yum -y install puppetserver

sudo systemctl start puppet
sudo systemctl status puppet
