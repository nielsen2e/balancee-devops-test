#!/bin/bash

# update package manager and install required packages
sudo apt-get update
sudo apt-get install -y python3 python3-pip python3-virtualenv nginx


# create a directory for the web app
mkdir -p /var/www/app


# create a Python virtual environment and activate it
python3 -m venv /var/www/app/myenv
source /var/www/hostname-app/myenv/bin/activate


# install required Python packages
pip3 install flask gunicorn


# create a simple Python web app that displays the hostname
echo 'from flask import Flask
import socket
app = Flask(__name__)

@app.route("/")
def get_hostname():
  hostname = socket.gethostname()
  return f'The hostname of the server is: {hostname}'

if __name__  == '__main__':
  app.run(host='0.0.0.0')' > /var/www/app/app.py


# create a WSGI entry point
echo 'from app import app
if __name__ == “__main__”:
  app.run()' > /var/www/app/wsgi.py


# create a configuration file for NGINX
echo 'server {
 listen 80;
 listen [::]:80;
location / {
 include proxy_params;
 proxy_pass http://127.0.0.1:8000;
 }
}' > /etc/nginx/sites-available/app


#Make the application Run as a service
echo '[Unit]
Description=Gunicorn instance to serve myproject
After=network.target
[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/myproject
Environment=”PATH=/home/ubuntu/myproject/myenv/bin”
ExecStart=/home/ubuntu/myproject/myenv/bin/gunicorn wsgi:app
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/app.service

#Start the gunicorn service
systemctl start app.service

# Enable the gunicorn service
systemctl enable app.service

# enable the web app configuration
ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/app

# restart NGINX
systemctl restart nginx

#enable NGINX
systemctl enable nginx