##### Setup WiFi

```
certbot.service
#FilePath: /lib/systemd/system/certbot.service
 
[Unit]
Description=Certbot
Documentation=file:///usr/share/doc/python-certbot-doc/html/index.html
Documentation=https://letsencrypt.readthedocs.io/en/latest/

[Service]
Type=oneshot
ExecStart=/usr/bin/certbot -q renew --deploy-hook /etc/letsencrypt/renewal-hooks/deploy/deploy_hook.sh
PrivateTmp=true
```

```
certbot.timer
#FilePath:/lib/systemd/system/certbot.timer

[Unit]
Description=Run certbot twice daily

[Timer]
OnCalendar=*-*-* 00,12:00:00
RandomizedDelaySec=43200
Persistent=true

[Install]
WantedBy=timers.target
```

```
deploy_hook.sh
#!/bin/sh
#FilePath: /etc/letsencrypt/renewal-hooks/deploy/deploy_hook.sh

openvpnas@openvpnas2:/usr/local/openvpn_as/scripts$ cat /etc/letsencrypt/renewal-hooks/deploy/deploy_hook.sh
export DOMAIN=myvpn.domain.com
sudo /usr/local/openvpn_as/scripts/confdba -mk cs.cert -v "`sudo cat /etc/letsencrypt/live/$DOMAIN/cert.pem`"
sudo /usr/local/openvpn_as/scripts/confdba -mk cs.priv_key -v "`sudo cat /etc/letsencrypt/live/$DOMAIN/privkey.pem`" > /dev/null
sudo /usr/local/openvpn_as/scripts/confdba -mk cs.ca_bundle -v "`sudo cat /etc/letsencrypt/live/$DOMAIN/fullchain.pem`"
``` 

```
myvpn.domain.com.conf
#FilePath:myvpn.domain.com.conf

# renew_before_expiry = 30 days
version = 0.31.0
archive_dir = /etc/letsencrypt/archive/myvpn.domain.com
cert = /etc/letsencrypt/live/myvpn.domain.com/cert.pem
privkey = /etc/letsencrypt/live/myvpn.domain.com/privkey.pem
chain = /etc/letsencrypt/live/myvpn.domain.com/chain.pem
fullchain = /etc/letsencrypt/live/myvpn.domain.com/fullchain.pem

# Options used in the renewal process
#You will need to configure aws-cli in order to open and close port 80 on the fly. This is needed for acme challenge to succeed on port 80. 
[renewalparams]
account = xxxxxxxxxxxxxxxxxxxxxxxxxxx
pre_hook = sudo service openvpnas stop && sudo service nginx stop &&  export AWS_DEFAULT_REGION=eu-west-1 && aws ec2 authorize-security-group-ingress --group-name "OpenVPN SG - C5" --protocol tcp --port 80 --cidr 0.0.0.0/0
post_hook = sudo service openvpnas start && sudo service nginx start && export AWS_DEFAULT_REGION=eu-west-1 && aws ec2 revoke-security-group-ingress --group-name "OpenVPN SG - C5" --protocol tcp --port 80 --cidr 0.0.0.0/0
authenticator = standalone
server = https://acme-v02.api.letsencrypt.org/directory
``` 




