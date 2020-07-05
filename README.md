# multi-controllers
sata sas scsi nvme ide

Travis (.com) dev branch:
[![Build Status](https://travis-ci.com/githubfoam/multi-controllers.svg?branch=dev)](https://travis-ci.com/githubfoam/multi-controllers)  


~~~
runs only locally - storage layout "storage_list.yml"

$ lsblk
NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda               8:0    0  64G  0 disk
├─sda1            8:1    0   1G  0 part /boot
└─sda2            8:2    0  63G  0 part
  ├─centos-root 253:0    0  41G  0 lvm  /
  ├─centos-swap 253:1    0   2G  0 lvm  [SWAP]
  └─centos-home 253:2    0  20G  0 lvm  /home
sdb               8:16   0   2G  0 disk
sdc               8:32   0   4G  0 disk
sdd               8:48   0   2G  0 disk
nvme0n1         259:0    0   2G  0 disk

~~~

~~~
http://wiki.lustre.org/VDBench
https://fio.readthedocs.io/en/latest/index.html
~~~
