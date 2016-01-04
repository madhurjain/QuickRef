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


Cleaning Up
-----------

- Most often, Wordpress core files are modified to include a PHP Shell for back door access or to inject spam content  
- Open Google WebMaster tools and check for links with hacked content
- Since this hacked content is only visible to Google Spider, install `User Agent Switcher` add-on in Firefox, 
  set the user agent to Googlebot and open the link with hacked content
- Follow the below steps and keep checking the link in question to make sure all the unwanted content is cleaned up
- If the code base is being tracked on `git` (which should be the case always), run `git status` and check for modified/added files
- Open these files in `nano` or `vim` editor and remove the suspicious code
- Update/Reinstall Wordpress core from dashboard which should overwrite the core files if they were modified
- Open the website in Chrome and check the `Console` for any errors relating to missing content and fix those
- Submit a Reconsideration Request from Webmaster Tools to get rid of the `This site may be hacked` message from Google results


