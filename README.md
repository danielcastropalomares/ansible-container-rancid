How to use
```
cd ansible-container-rancid
ansible-build
```

Now you can start a docker with the next options:
```
docker run --name test10 -v /tmp/test10:/var/lib/rancid -e RANCID_GROUPS="bcn mad" -p 4444:443 -d ansible-container-rancid-web:last
```

