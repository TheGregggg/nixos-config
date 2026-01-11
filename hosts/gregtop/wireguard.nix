{...}: {
  networking.firewall.allowedUDPPorts = [49696];

  networking.wireguard = {
    enable = true;
    # interfaces = {
    #   wg0 = {
    #     ips = ["10.69.1.11/32"];
    #     listenPort = 49696;
    #     privateKeyFile = "/home/gregoire/nixos-config/secrets/wireguard/gregtop-private";

    #     peers = [
    #       {
    #         name = "wireguardVPN";
    #         publicKey = "ycY9O5x5lO51/DNq5oHzIkTotqpbaFgnb3CMmxLMS3c=";
    #         allowedIPs = [
    #           "10.69.1.0/24"
    #           "10.69.0.0/24"
    #         ];
    #         endpoint = builtins.readFile ./wireguardvpn;
    #         persistentKeepalive = 25;
    #       }
    #     ];
    #   };
    # };
  };
}
