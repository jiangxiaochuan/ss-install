#!/bin/bash
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py

pip install --upgrade pip
pip install shadowsocks

cat > /etc/shadowsocks.json <<EOF 

{
  "server": "0.0.0.0",
  "server_port": 9527,
  "password": "9527ok",
  "method": "aes-256-cfb"
}

EOF

cat > /etc/systemd/system/shadowsocks.service <<EOF 

[Unit]
Description=Shadowsocks
[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json
[Install]
WantedBy=multi-user.target

EOF

systemctl enable shadowsocks

systemctl start shadowsocks
