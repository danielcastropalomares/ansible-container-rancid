#!/bin/bash
RANCIDCONF=/etc/rancid/rancid.conf
if ! grep -q "RANCID_GROUPS" /etc/environment; then
    /bin/echo "Install env in /etc/environment"   
    /bin/echo "RANCID_GROUPS=$RANCID_GROUPS" >> /etc/environment 
fi
#check if the directory /var/lib/rancid/bin, if not reinstall rancid and place the correct files
if [ ! -d /var/lib/rancid/bin ]; then
   /bin/echo "Reinstall package rancid"
   /bin/chown rancid:rancid /var/lib/rancid
   /usr/bin/apt-get update
   /usr/bin/apt-get install --reinstall rancid
fi
#CHECK if the group is create on the folder /var/lib/rancid/ 
#for GROUP in $(/bin/grep ^LIST_OF_GROUPS $RANCIDCONF | /usr/bin/awk -F '"' {'print $2'} ); do
for GROUP in $RANCID_GROUPS; do
    if [ ! -d "/var/lib/rancid/$GROUP" ]; then
        /bin/echo "create the  $GROUP in /var/lib/rancid"
        /bin/su - rancid -c '/usr/lib/rancid/bin/rancid-cvs'
    fi
done
echo "Create the file .htpasswd on  $htpasswd_path"
/usr/bin/htpasswd -b -c $htpasswd_path/.htpasswd $htaccess_user $htaccess_pw 
/usr/sbin/cron -f &
/bin/rm -f /usr/local/apache2/logs/httpd.pid
/usr/sbin/apache2ctl -D FOREGROUND
