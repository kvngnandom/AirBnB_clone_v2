#!/usr/bin/env bash
<<<<<<< HEAD
# Sets up a web server for deployment of web_static.

apt-get update
apt-get install -y nginx

mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
echo "Holberton School" > /data/web_static/releases/test/index.html
ln -sf /data/web_static/releases/test/ /data/web_static/current

chown -R ubuntu /data/
chgrp -R ubuntu /data/

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;

    location /hbnb_static {
	alias /data/web_static/current;
	index index.html index.htm;
    }

    location /redirect_me {
	return 301 http://cuberule.com/;
    }

    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

=======
# Set up a web server for the development of web_static
# Update and install nginx if not installed
sudo apt -y update
sudo apt install -y nginx

# Create directories and sub directories if they don't exist yet
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/
sudo touch /data/web_static/releases/test/index.html

# Create a fake HTML file for testing Nginx configuration
cat <<EOF | sudo tee /data/web_static/current/index.html > /dev/null
<html>
  <head>
  </head>
  <body>
    Testing Nginx Configuration
  </body>
</html>
EOF

# Createa symbolic link to remove and recreate if not exists
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Write permmissions to user and group
sudo chown -R ubuntu:ubuntu /data/
sudo sed -i "44i \\\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}" /etc/nginx/sites-available/default

# Restart nginx service
>>>>>>> ccc5eadbc057493b89ca6fcaf2341f86c469894b
service nginx restart
