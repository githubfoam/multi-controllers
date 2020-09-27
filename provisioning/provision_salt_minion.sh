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

# yum install salt-minion -y #No package salt-minion available.
# chkconfig salt-minion on
# echo 'client1' >> /etc/salt/minion_id
# echo 'client2' >> /etc/salt/minion_id
# service salt-minion start
# service salt-minion status