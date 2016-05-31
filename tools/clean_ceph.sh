#!/bin/sh

service ceph -a stop

rm /etc/ceph/* -rf

for dir in `ls /var/lib/ceph/osd/`
do
  rm /var/lib/ceph/osd/$dir/* -rf
  umount /var/lib/ceph/osd/$dir
done

rm /var/lib/ceph/mon/* -rf
rm /var/lib/ceph/osd/* -rf
