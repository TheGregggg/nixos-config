{...}: {
  networking.firewall.allowedTCPPorts = [8089];

  home-manager.users.gregoire.home.file."/home/gregoire/nixos/wolweb-devices.json".source = ./wolweb-devices.json;

  virtualisation.oci-containers.containers = {
    wolweb = {
      image = "ghcr.io/sameerdhoot/wolweb";
      extraOptions = [
        "--network=host"
      ];
      volumes = [
        "/home/gregoire/nixos/wolweb-devices.json:/wolweb/devices.json"
      ];
      environment = {
        WOLWEBHOST = "0.0.0.0";
        WOLWEBPORT = "8089";
        WOLWEBBCASTIP = "192.168.1.255:9";
      };
    };
  };
}
