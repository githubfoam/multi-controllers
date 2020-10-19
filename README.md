# multi-controllers
sata sas scsi nvme ide

Travis (.com) dev branch:
[![Build Status](https://travis-ci.com/githubfoam/multi-controllers.svg?branch=master)](https://travis-ci.com/githubfoam/multi-controllers)  


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
vagrant@vg-controller-87:~$ hostnamectl
   Static hostname: vg-controller-87
         Icon name: computer-vm
           Chassis: vm
        Machine ID: 757008b83347405e95471966671ea4bd
           Boot ID: b12b17903caf4f23a3eef0bbf4b359b7
    Virtualization: oracle
  Operating System: Debian GNU/Linux 10 (buster)
            Kernel: Linux 4.19.0-9-amd64
      Architecture: x86-64

      vagrant@vg-controller-87:~$ fio
      -bash: fio: command not found
      vagrant@vg-controller-87:~$ docker image ls
      REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
      githubfoam          fio.alpine          a611bd969a1e        35 minutes ago      7.37MB
      alpine              latest              a24bb4013296        5 weeks ago         5.57MB


$ sudo docker run githubfoam:fio.alpine --name=randwrite --ioengine=libaio --iodepth=1 --rw=randwrite --bs=4k --direct=0 --size=2M -
-numjobs=4 --runtime=240 --group_reporting
randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=1
...
fio-3.20
Starting 4 processes
randwrite: Laying out IO file (1 file / 2MiB)
randwrite: Laying out IO file (1 file / 2MiB)
randwrite: Laying out IO file (1 file / 2MiB)
randwrite: Laying out IO file (1 file / 2MiB)

randwrite: (groupid=0, jobs=4): err= 0: pid=9: Mon Jul  6 15:12:13 2020
  write: IOPS=2461, BW=9846KiB/s (10.1MB/s)(8192KiB/832msec); 0 zone resets
    slat (usec): min=4, max=207251, avg=1007.36, stdev=14251.98
    clat (usec): min=2, max=2556, avg= 6.26, stdev=56.91
     lat (usec): min=7, max=207264, avg=1013.74, stdev=14252.45
    clat percentiles (usec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    3], 20.00th=[    3],
     | 30.00th=[    3], 40.00th=[    3], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    7], 80.00th=[    7], 90.00th=[    7], 95.00th=[    7],
     | 99.00th=[   31], 99.50th=[   44], 99.90th=[  139], 99.95th=[  231],
     | 99.99th=[ 2573]
   bw (  KiB/s): min= 6265, max= 6266, per=63.64%, avg=6266.00, stdev= 0.00, samples=2
   iops        : min= 1565, max= 1566, avg=1566.00, stdev= 0.00, samples=2
  lat (usec)   : 4=67.09%, 10=30.13%, 20=1.17%, 50=1.27%, 100=0.20%
  lat (usec)   : 250=0.10%
  lat (msec)   : 4=0.05%
  cpu          : usr=0.00%, sys=1.10%, ctx=27, majf=0, minf=48
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,2048,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
  WRITE: bw=9846KiB/s (10.1MB/s), 9846KiB/s-9846KiB/s (10.1MB/s-10.1MB/s), io=8192KiB (8389kB), run=832-832msec

Disk stats (read/write):
    dm-0: ios=62/578, merge=0/0, ticks=2056/128, in_queue=3104, util=87.84%, aggrios=140/617, aggrmerge=23/4638, aggrticks=3246/1107, aggrin_queue=4284, aggrutil=86.91%
  sda: ios=140/617, merge=23/4638, ticks=3246/1107, in_queue=4284, util=86.91%


~~~

~~~
http://wiki.lustre.org/VDBench
https://fio.readthedocs.io/en/latest/index.html

memory-to-memory network throughput

nuttcp
http://nuttcp.net/Welcome%20Page.html
iperf3
https://software.es.net/iperf/

fio cheatsheet
https://gist.github.com/githubfoam/a678cfc813c7ede6ca9ecb93e34edd8e
~~~
