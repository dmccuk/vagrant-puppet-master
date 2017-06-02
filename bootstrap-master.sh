#!/bin/sh

# Run on VM to bootstrap Puppet Master server

if ps aux | grep "puppet master" | grep -v grep 2> /dev/null
then
    echo "Puppet Master is already installed. Exiting..."
    exit 0
else
    # Install Puppet Master
    wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
    sudo dpkg -i puppetlabs-release-trusty.deb
    sudo apt-get update -yq
    sudo apt-get upgrade -yq
    sudo apt-get install -yq puppetmaster

    # Add optional alternate DNS names to /etc/puppet/puppet.conf
    sudo sed -i 's/.*\[main\].*/&\ndns_alt_names = puppet,puppet.example.com/' /etc/puppet/puppet.conf
     sudo sed -i 's/.*\[master\].*/&\nautosign = true/' /etc/puppet/puppet.conf

fi
