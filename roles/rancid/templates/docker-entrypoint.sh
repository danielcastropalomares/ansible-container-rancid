#!/bin/bash
RANCIDCONF=/etc/rancid/rancid.conf
if ! grep -q "RANCID_GROUPS" /etc/environment; then
       echo "RANCID_GROUPS=$RANCID_GROUPS" >> /etc/environment 
fi
#check if the directory /var/lib/rancid/bin, if not reinstall rancid and place the correct files
if [ ! -d /var/lib/rancid/bin ]; then
   /bin/chown rancid:rancid /var/lib/rancid
   /usr/bin/apt-get update
   /usr/bin/apt-get install --reinstall rancid
fi
#CHECK if the group is create on the folder /var/lib/rancid/ 
#for GROUP in $(/bin/grep ^LIST_OF_GROUPS $RANCIDCONF | /usr/bin/awk -F '"' {'print $2'} ); do
for GROUP in $RANCID_GROUPS; do
    if [ ! -d "/var/lib/rancid/$GROUP" ]; then
        /bin/su - rancid -c '/usr/lib/rancid/bin/rancid-cvs'
    fi
done
/usr/sbin/cron -f &
/usr/sbin/apache2ctl -D FOREGROUND
