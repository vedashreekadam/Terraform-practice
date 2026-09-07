#!/bin/bash
set -xe

dnf update -y
dnf install -y python3 python3-pip httpd

# Install Streamlit without touching RPM packages
pip3 install --ignore-installed --prefix /usr/local streamlit

mkdir -p /home/ec2-user/app

cat << 'EOF' > /home/ec2-user/app/app.py
import streamlit as st
st.title("Hello Vedashree!")
st.write("Your Streamlit app is running on EC2 with Apache reverse proxy.")
EOF

cat << 'EOF' > /etc/systemd/system/streamlit.service
[Unit]
Description=Streamlit App
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/app
ExecStart=/usr/local/bin/streamlit run app.py --server.port 8501 --server.address 0.0.0.0
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable streamlit
systemctl start streamlit

cat << 'EOF' > /etc/httpd/conf.d/streamlit.conf
ProxyPreserveHost On
ProxyRequests Off

RewriteEngine On

# WebSocket support
RewriteCond %{HTTP:Upgrade} =websocket [NC]
RewriteRule /(.*) ws://127.0.0.1:8501/$1 [P,L]

# Normal HTTP proxy
ProxyPass / http://127.0.0.1:8501/
ProxyPassReverse / http://127.0.0.1:8501/
EOF


systemctl enable httpd
systemctl start httpd
