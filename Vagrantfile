# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"
# YAML module for reading box configurations.
require 'yaml'
#  server configs from YAML/YML file
servers_list = YAML.load_file(File.join(File.dirname(__FILE__), 'provisioning/servers_list.yml'))

$docker_build_script = <<SCRIPT
echo "==========================build alpine fio=========================================================="
sudo docker build -t githubfoam:fio.alpine -<<EOF

# job file without volume mount (read speed inside docker)
# docker run githubfoam/fio /jobs/rand-read.fio
# job file with volume mount
# docker run -v $(pwd)/data:/data githubfoam/fio /jobs/rand-read.fio
# custom fio job file
# docker run -v $(pwd)/data:/data -v /path/to/job.fio:/jobs/job.fio githubfoam/fio /jobs/job.fio
FROM alpine
RUN apk add --no-cache fio
VOLUME /data
WORKDIR /data
ENTRYPOINT [ "fio" ]
EOF
echo "===================================================================================="
echo "==========================build ubuntu fio=========================================================="
sudo docker build -t githubfoam:fio.ubuntu -<<EOF

FROM ubuntu:20.10
# RUN apt-get -qqy update && apt-get install -qqy fio \
#    wget \
#    libqt5gui5 \
#    gnuplot \
#    python2.7

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -qqy tzdata &&\ # set noninteractive installation
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime &&\ ## set your timezone
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update -qq && \
    apt-get -qqy install fio \
    tzdata \
    wget \
    libqt5gui5 \
    gnuplot \
    python2.7

VOLUME /data
WORKDIR /data
ENTRYPOINT [ "fio" ]
EOF
echo "===================================================================================="
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 # Disable updates
 config.vm.box_check_update = false

      servers_list.each do |server|
        config.vm.define server["vagrant_box_host"] do |box|
          box.vm.box = server["vagrant_box"]
          box.vm.hostname = server["vagrant_box_host"]
          box.vm.network server["network_type"], ip: server["vagrant_box_ip"]
          box.vm.network "forwarded_port", guest: server["guest_port"], host: server["host_port"],  id: 'elastic_port'

          box.vm.synced_folder "pillar/", "/srv/pillar/"
          box.vm.synced_folder "salt/", "/srv/salt/"

          box.vm.provider "virtualbox" do |vb|
              vb.name = server["vbox_name"]
              vb.memory = server["vbox_ram"]
              vb.cpus = server["vbox_cpu"]
              vb.gui = false
              vb.customize ["modifyvm", :id, "--groups", "/multicontroller-grp"] # create vbox group

              unless server["storage_bootstrap"].to_s.strip.empty?
                #  server configs from YAML/YML file
                devices_list = YAML.load_file(File.join(File.dirname(__FILE__), 'provisioning/storage_list.yml'))
                devices_list.each do |device|
                  case device["system_bus_type"]
                  when "ide" # existing controller only, boor order problem
                    vb.customize ["createmedium", "--filename", device["file_to_controller_disk"], "--variant", "Fixed", "--size", device["controller_disk_size"]]
                    vb.customize ["storageattach", :id, "--storagectl", device["system_bus_name"], "--type", device["medium_type"], "--medium", device["file_to_controller_disk"], "--port", device["medium_port"], "--device", device["medium_device"]]
                  when "sata" # existing controller only
                    vb.customize ["createmedium", "--filename", device["file_to_controller_disk"], "--variant", "Fixed", "--size", device["controller_disk_size"]]
                    vb.customize ["storageattach", :id, "--storagectl", device["system_bus_name"], "--type", device["medium_type"], "--medium", device["file_to_controller_disk"], "--port", device["medium_port"]]
                  else
                    vb.customize ["createmedium", "--filename", device["file_to_controller_disk"], "--variant", "Fixed", "--size", device["controller_disk_size"]]
                    vb.customize ["storagectl", :id, "--name", device["system_bus_name"], "--add", device["system_bus_type"], "--controller", device["disk_controller_type"], "--portcount", device["disk_controller_portcount"], "--bootable", "off", "--hostiocache", "on"]
                    vb.customize ["storageattach", :id, "--storagectl", device["system_bus_name"], "--type", device["medium_type"], "--medium", device["file_to_controller_disk"], "--port", device["medium_port"]]
                  end # end of case

                end # end of unless

              end

          end # end of box.vm.providers

          # box.vm.provision :shell, path: "scripts/bootstrap.sh"
          # box.vm.provision "shell", inline: <<-SHELL
          # echo "===================================================================================="
          # SHELL
          box.vm.provision "shell", path: server["server_script"]

          box.vm.provision "ansible_local" do |ansible|
              # ansible.compatibility_mode = "2.0"
              ansible.compatibility_mode = server["ansible_compatibility_mode"]
              # ansible.version = server["ansible_version"] # not pinning version for auto updates
              ansible.playbook = server["server_bootstrap"]
              # ansible.inventory_path = 'provisioning/hosts'
              # ansible.verbose = "vvvv" # debug
              # ansible.galaxy_role_file = "/vagrant/requirements.yml"
              # ansible.galaxy_roles_path = "/etc/ansible/roles"
              # ansible.galaxy_command = "sudo ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path} --force"
           end # end if box.vm.provision

          #depends on ansible provisioning that installs docker docker-compose
          # box.vm.provision "shell", inline: $docker_build_script, privileged: false

        end # end of config.vm
      end  # end of servers_list.each loop
end # end of Vagrant.configure
