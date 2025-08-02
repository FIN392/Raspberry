# VPN-con-Tailscale
Cómo usar una Raspberry Pi para instalar Tailscale

```
# Instalar Tailscale en la raspberry
curl -fsSL https://tailscale.com/install.sh | sh

# Inciar el servicio
tailscale up

# URL para dar de alta el dispositivo
https://login.tailscale.com/a/9f9f9f9f99f9f9

# Como ver los dispositivos
tailscale status

# Instalar Subnet router
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sudo sysctl -p /etc/sysctl.d/99-tailscale.conf




```

