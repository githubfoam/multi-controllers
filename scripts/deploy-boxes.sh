#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
vagrant plugin install vagrant-libvirt #The vagrant-libvirt plugin is required when using KVM on Linux
vagrant plugin install vagrant-mutate #Convert vagrant boxes to work with different providers

# https://app.vagrantup.com/archlinux
# vagrant box add "archlinux/archlinux" --provider=libvirt
# vagrant up --provider=libvirt vg-arch-01
# # vagrant ssh vg-arch-01 -c "hostnamectl"

vagrant box add "bento/centos-7.7" --provider=virtualbox
vagrant mutate "bento/centos-7.7" libvirt
vagrant up --provider=libvirt "vg-controller-82"


vagrant box list #veridy installed boxes
vagrant status #Check the status of the VMs to see that none of them have been created yet
vagrant status
virsh list --all #show all running KVM/libvirt VMs
