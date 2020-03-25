```sh
cd /etc/nginx/sites-available
vim hostname.com
```


```
server {
	server_name *.hostname.com;
	rewrite ^(.*) http://hostname.com$1 permanent;
}
server {
	server_name hostname.com;
	access_log /var/log/nginx/hostname.com.access.log;
	error_log /var/log/nginx/hostname.com.error.log;
	root /var/www/hostname.com;
	index index.php;

	location / {
		try_files $uri $uri/ /index.php?$args;
	}

	location ~ \.php$ {
		try_files $uri /index.php =404;
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
		fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

		include fastcgi_params;
	}

	# Show "Not Found" 404 errors in place of "Forbidden" 403 errors, because
	# forbidden errors allow attackers potential insight into your server's
	# layout and contents
	error_page 403 =404;

	# Prevent access to any files starting with a dot, like .htaccess
	# or text editor temp files
	location ~ /\. { access_log off; log_not_found off; deny all; }

	# Prevent access to any files starting with a $ (usually temp files)
	location ~ ~$ { access_log off; log_not_found off; deny all; }

	# Do not log access to robots.txt, to keep the logs cleaner
	location = /robots.txt { access_log off; log_not_found off; }

	# Do not log access to the favicon, to keep the logs cleaner
	location = /favicon.ico { access_log off; log_not_found off; }

	location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
		expires max;
		log_not_found off;
	}

	# Common deny or internal locations, to help prevent access to areas of
	# the site that should not be public
	location ~* wp-admin/includes { deny all; }
	location ~* wp-includes/theme-compat/ { deny all; }
	location ~* wp-includes/js/tinymce/langs/.*\.php { deny all; }
	location /wp-content/ { internal; }
	location /wp-includes/ { internal; }

	# The next line protects the wp-config.php file from being accessed, but
	# we need to be able to run the file for the initial site setup. Uncomment
	# the next line after setup is completed and reload Nginx.
	location ~* wp-config.php { deny all; }

}
```

```sh
ln -s /etc/nginx/sites-available/hostname.com /etc/nginx/sites-enabled
```

## Test Nginx Configuration

```sh
sudo systemctl stop nginx
```

## Start / Stop / Restart / Reload Nginx

```sh
sudo systemctl stop nginx
sudo systemctl start nginx
sudo systemctl restart nginx
sudo systemctl reload nginx
sudo systemctl disable nginx
sudo systemctl enable nginx
```
