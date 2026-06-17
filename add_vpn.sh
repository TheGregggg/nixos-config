sudo su -c "nmcli connection delete wireguardvpn &2> /dev/null"
sudo su -c" nmcli connection import type wireguard file hosts/gregtop/wireguardvpn.conf"
sudo su -c "nmcli connection modify wireguardvpn connection.autoconnect no"