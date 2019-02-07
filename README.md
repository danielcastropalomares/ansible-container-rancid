# How to use
```
cd ansible-container-rancid
ansible-build
```

Now you can start a docker with the next options:
```
docker run --name test10 -v /tmp/test10:/var/lib/rancid -e RANCID_GROUPS="bcn mad" -p 4444:443 -d ansible-container-rancid-web:last
```

The backup is excecuted every night 3:00 o'clock via cron:
```
/etc/cron.d/rancid
0 3 * * * rancid /usr/bin/rancid-run
```
Is mandatory mount a permanent volume for directory /var/lib/rancid, in this directory is saved the backups of devices.



# Steps after deploy container

It's most important execute the next instructions with the user rancid.

Create the file .clogin:
```
su - rancid
vi /var/lib/rancid/.clogin
```
Add the credentials:
```
	add user 172.16.3.1          admin
	add password 172.16.3.1      XXXXXXX
	add method 172.16.3.1       ssh
	add autoenable 172.16.3.1        1
  ```
  
  Change the permisions of file:
  ```
  chmod 600 /var/lib/rancid/.clogin
  ```
  Try connect to device:
  ```
  /var/lib/rancid/bin/clogin 172.16.3.1
  ```
  Finally add the device inside to router.db:
  ```
   vi /var/lib/rancid/mad/router.db
   172.16.3.1;cisco;up
   ```
   
   You can browse the backups with the next url:
   ```
   https://localhost:4444/cgi-bin/cvsweb/
   ```
