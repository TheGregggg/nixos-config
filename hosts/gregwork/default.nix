# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/system.nix
    ../../modules/podman.nix
    #../../modules/numlock.nix

    ./hardware-configuration.nix
    ./system-apps.nix
  ];

  # Bootloader config
  boot = {
    kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel.
    loader = {
      systemd-boot.enable = lib.mkForce false;

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    # Lanzaboote currently replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false
    # for now.
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    initrd.luks.devices."luks-88c54c8b-32bb-457b-b898-4e509d23cf38".device = "/dev/disk/by-uuid/88c54c8b-32bb-457b-b898-4e509d23cf38";
  };

  gregConfig.gnomeDesktop.enable = true;

  networking.hostName = "gregwork"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services.xserver.xkb = {
    layout = lib.mkForce "us";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    # For debugging and troubleshooting Secure Boot.
    sbctl

    openscad

    tio
    dediprog-sf100
    saleae-logic-2
  ];

  hardware.saleae-logic.enable = true;
  users.users.gregoire.extraGroups = ["plugdev"];

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  hardware.bluetooth.powerOnBoot = false;

  #ncfg.services.numlock-on-tty.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
