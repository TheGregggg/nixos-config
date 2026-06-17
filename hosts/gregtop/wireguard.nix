{...}: {
  networking.firewall.allowedUDPPorts = [49696];

  networking.wireguard.enable = true;
}
