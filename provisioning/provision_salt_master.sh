#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "===================================================================================="
                          hostnamectl status
echo "===================================================================================="
echo "         \   ^__^                                                                  "
echo "          \  (oo)\_______                                                          "
echo "             (__)\       )\/\                                                      "
echo "                 ||----w |                                                         "
echo "                 ||     ||                                                         "
echo "==================================================================================="

echo '192.168.18.88 salt' >> /etc/hosts
cat /etc/hosts

yum install git salt-master -y
chkconfig salt-master on
cp -f /vagrant/master /etc/salt/
service salt-master start
service salt-master status

yum install salt-minion -y
chkconfig salt-minion on
echo 'master' >> /etc/salt/minion_id
service salt-minion start
service salt-minion status
crontab -l | fgrep -i -v 'salt-key -A -y' | echo '* * * * * salt-key -A -y' | crontab -