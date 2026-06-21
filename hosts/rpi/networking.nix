{
  pkgs,
  lib,
  ...
}: {
  networking.useDHCP = lib.mkDefault true;

  networking.firewall.allowedUDPPorts = [49696];

  # enable NAT
  networking.nat = {
    enable = true;
    externalInterface = "enu1u1";
    internalInterfaces = ["wg0"];
  };

  networking.wireguard = {
    enable = true;
    interfaces = {
      # network interface name.
      # You can name the interface arbitrarily.
      wg0 = {
        # the IP address and subnet of this peer
        ips = ["10.69.1.1/32"];

        # WireGuard Port
        # Must be accessible by peers
        listenPort = 49696;

        # Path to the private key file.
        #
        # Note: can also be included inline via the privateKey option,
        # but this makes the private key world-readable;
        # using privateKeyFile is recommended.
        privateKeyFile = "/home/gregoire/nixos/privatekey";

        peers = [
          {
            name = "gregphone";
            publicKey = "NZMqyaLZBWWePkQt+6zWXK5qd830gT9L4xpt28z7bWQ=";
            allowedIPs = [
              "10.69.1.20/32"
            ];
          }
          {
            name = "gregtop";
            publicKey = "rt9/EAlSodwQ52QlXAlWKpbBeo1iTRM7EbpSJ0EWVgI=";
            allowedIPs = [
              "10.69.1.11/32"
            ];
          }
          {
            name = "enotop";
            publicKey = "DAC1CRygDkcQ6FBjMsOPaGQXJd7wQ7M2CMywIy7pOBY=";
            allowedIPs = [
              "10.69.1.12/32"
            ];
          }
          {
            name = "enotablette";
            publicKey = "BFbEZpTR6WCb9DatJCMUJg9QqESI8ofmXbxJfcXotkQ=";
            allowedIPs = [
              "10.69.1.22/32"
            ];
          }
        ];

        # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
        postSetup = ''
          ${pkgs.sysctl}/bin/sysctl -w net.ipv4.ip_forward=1
          # IP masquerading
          ${pkgs.iptables}/bin/iptables -t mangle -A PREROUTING -i wg0 -j MARK --set-mark 0x30
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING ! -o wg0 -m mark --mark 0x30 -j MASQUERADE
        '';

        # Undo the above
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t mangle -D PREROUTING -i wg0 -j MARK --set-mark 0x30
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING ! -o wg0 -m mark --mark 0x30 -j MASQUERADE
        '';
      };
    };
  };
}
