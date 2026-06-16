{...}: {
  imports = [
    ../../modules/system.nix
    ../../modules/gnome.nix
    ../../modules/podman.nix
    ../../modules/switch.nix
    #../../modules/numlock.nix

    ./hardware-configuration.nix
    ./system-apps.nix
    ./wireguard.nix
  ];

  # Bootloader config
  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 10;
      windows."10" = {
        title = "Windows 10 Home - DJ mode";
        efiDeviceHandle = "FS0";
        sortKey = "z_windows";
      };
    };

    timeout = 0;

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  networking.hostName = "gregtop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [8096];
  networking.firewall.allowedUDPPorts = [7359 5000];

  hardware.bluetooth.powerOnBoot = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
