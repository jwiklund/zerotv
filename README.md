# zerotv

Config for pi zero w

## Configuration

### Web page
Expose public/index.html to server behind https.

### Install utils

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
```
