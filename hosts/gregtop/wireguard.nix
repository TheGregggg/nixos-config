{...}: let
  secrets = import ../../modules/secrets.nix;
  inherit (secrets.network.vpn) nodePubkey endpoint port;
in {
  networking.firewall.allowedUDPPorts = [49696];

  networking.wireguard.enable = true;

  # when i'll be home :
  # https://codeberg.org/siblingsofthevoid/nixos-config/commit/e6086957c8f5b5a3e152ec07e9dbfaea50422ab8

  networking.networkmanager.ensureProfiles = {
    profiles = {
      wireguardvpn = {
        connection = {
          autoconnect = "true";
          id = "wireguardvpn";
          interface-name = "homelab";
          type = "wireguard";
          uuid = "41637a2c-d1da-4d43-973d-ab82c9579102";
        };
        wireguard = {
          private-key-flags = 1;
        };
        ipv4 = {
          address1 = "10.69.1.11/32";
          method = "manual";
        };
        ipv6 = {
          addr-gen-mode = "default";
          method = "disabled";
        };
        proxy = {};
        "wireguard-peer.${nodePubkey}" = {
          allowed-ips = "10.69.1.0/24;10.69.0.0/24;";
          endpoint = "${endpoint}:${toString port}";
        };
      };
    };
    secrets.entries = [
      {
        file = "/home/gregoire/nixos-config/secrets/wireguard/gregtop-private";
        key = "private-key";
        matchId = "wireguardvpn";
        matchSetting = "wireguard";
        matchType = "wireguard";
      }
    ];
  };
}
