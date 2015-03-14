SSL
---

Generate a private key from within the Start SSL control panel.
Save it securely.



cat pleximus.crt sub.class3.server.ca.pem ca.pem > pleximus.crt

private.key


##### Remove password from private key

openssl rsa -in ssl.key -out ssl.key


##### 

If you get a PEM_read_bio error on `nginx -t`
Open concatinated .crt file in vim and add a new line in between
where the new line is missing