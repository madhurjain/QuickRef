Wordpress Hardening
-------------------

#### Default File Permissions

```sh
find /var/www/wordpress -type d -exec chmod 755 {} \;
find /var/www/wordpress -type f -exec chmod 644 {} \;
```

#### Disable File Editing

Add to wp-config.php

```
define('DISALLOW_FILE_EDIT', true);
```

#### Security through obscurity

- Rename admin account 
- Change default table prefix `wp_`

##### Nginx: Disable PHP execution in /uploads

