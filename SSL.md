SSL
---

## Let's Encrypt

https://certbot.eff.org/#ubuntutrusty-nginx

Download Certbot
```sh
cd ~
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
```

`$ ./certbot-auto`

Obtain the certificate

`$ ./certbot-auto certonly --webroot -w /var/www/example -d example.com -d www.example.com`


Generating key (2048 bits): /etc/letsencrypt/keys/0000_key-certbot.pem
Creating CSR: /etc/letsencrypt/csr/0000_csr-certbot.pem

Debug log is saved at `/var/log/letsencrypt/letsencrypt.log`
Certificate and chain is saved at `/etc/letsencrypt/live/example.com/fullchain.pem.`

Let's Encrypt Account is saved at `/etc/letsencrypt/accounts/` and can be backed-up

### Renew

```sh
./certbot-auto renew --nginx
```

## StartSSL

Generate a private key from within the Start SSL control panel. Save it securely.

`cat key.crt sub.class3.server.ca.pem ca.pem > key.crt`


##### Remove password from private key

`openssl rsa -in ssl.key -out ssl.key`

If you get a PEM_read_bio error on `nginx -t`
Open concatenated .crt file in vim and add a new line in between where the new line is missing