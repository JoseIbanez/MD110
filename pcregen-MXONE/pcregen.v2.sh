#!/bin/sh

trabajo='/home/eri_sn_admin/pcregen/'
directorio=`date +%Y%m%d-%H%M`
rai=`hostname -d`

cd $trabajo
mkdir ./$directorio
cd ./$directorio/
source ../pcregen.v2.txt
#cp /var/lib/dhcp/db/dhcpd.leases .
cd ..
chown -R eri_sn_admin.root ./$directorio

tar -cz -f pcregen-$rai-$directorio.tgz ./$directorio


#Subir a servidor de backup's
chmod 400 ./rsync.pwd
chown root.root ./rsync.pwd
rsync -a --password-file ./rsync.pwd *.tgz rsync://fibratel@10.106.0.23:/stg2/backups/pcregen
