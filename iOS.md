Apple Push Notification Service
-------------------------------

1. Go to Apple Member Center https://developer.apple.com `Certificates`
2. Select `Apple Push Notification service SSL (Sandbox)` and Add new certificate.
3. Create a CSR from Keychain Access on Mac
4. Upload this CSR
5. Download the `.cer` file
6. Open and Import it in Keychain Access
7. Export the private key as .p12 file
8. In the directory containing cert.cer and key.p12,
   execute the following commands to generate your .pem files

```sh
$ openssl x509 -in aps_development.cer -inform DER -outform PEM -out aps_development.pem
$ openssl pkcs12 -in key.p12 -out key.pem -nodes
```