#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
vagrant plugin install vagrant-libvirt #The vagrant-libvirt plugin is required when using KVM on Linux
vagrant plugin install vagrant-mutate #Convert vagrant boxes to work with different providers

echo "========================================================================================="
# #https://github.com/chef/bento/tree/master/packer_templates/centos
# vagrant box add "bento/centos-7.8" --provider=virtualbox
# vagrant mutate "bento/centos-7.8" libvirt
# vagrant up --provider=libvirt "vg-controller-82"

# Ansible provision OK
#https://github.com/chef/bento/tree/master/packer_templates/centos
# vagrant box add "bento/centos-8.2" --provider=virtualbox
# vagrant mutate "bento/centos-8.2" libvirt
# vagrant up --provider=libvirt "vg-controller-83"

#No output has been received in the last 10m0s, this potentially indicates a stalled build or something wrong with the build itself.
#https://github.com/chef/bento/tree/master/packer_templates/centos
# vagrant box add "bento/fedora-32" --provider=virtualbox
# vagrant mutate "bento/fedora-32" libvirt
# vagrant up --provider=libvirt "vg-controller-84"

# Ansible provision OK
# https://app.vagrantup.com/centos/boxes/8
# vagrant box add "centos/8" --provider=libvirt
# vagrant up --provider=libvirt "vg-controller-85"

#vg-controller-86: /tmp/vagrant-shell: line 8:  3409 Killed                  dnf -y update
# https://app.vagrantup.com/fedora/boxes/32-cloud-base
# vagrant box add "fedora/32-cloud-base" --provider=libvirt
# vagrant up --provider=libvirt "vg-controller-86"

# vagrant box add "bento/debian-10.4" --provider=virtualbox
# vagrant mutate "bento/debian-10.4" libvirt
# vagrant up --provider=libvirt "vg-controller-87"

# Saltstack provisioning
# https://app.vagrantup.com/centos/boxes/8
vagrant box add "centos/8" --provider=libvirt
vagrant up --provider=libvirt "master"
vagrant up --provider=libvirt "client1"
vagrant up --provider=libvirt "client2"

vagrant box list #veridy installed boxes
vagrant status #Check the status of the VMs to see that none of them have been created yet
vagrant status
virsh list --all #show all running KVM/libvirt VMs
