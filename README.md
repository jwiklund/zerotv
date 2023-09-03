# zerotv

Config for pi zero w

## Configuration

### Install tools

```bash
make cloudflared
make dist-cloudflared

make pi-wifi
make dist-pi-wifi
```

### Enable WIFI Configuration
https://superuser.com/questions/219108/not-authorized-to-control-networking-in-ssh-console

```bash
cat | sudo tee /etc/polkit-1/localauthority/50-local.d/allow-networking.pkla <<EOF
[Let adm group modify system settings for network]
Identity=unix-group:adm
Action=org.freedesktop.NetworkManager.network-control
ResultAny=yes
EOF

sudo systemctl restart polkit
```

### Install pi-wifi service

```bash
cat | sudo tee /etc/systemd/system/pi-wifi.service <<EOF
system/pi-wifi.service
[Unit]
Description=pi-wifi
After=bluetooth.target

[Service]
ExecStart=/home/$USER/pi-wifi/pi-wifi server
WorkingDirectory=/home/$USER/pi-wifi
User=$USER
Group=adm

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable pi-wifi
sudo systemctl start pi-wifi
```

### Web page
Expose public/index.html to a server behind https.
