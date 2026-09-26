# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/workstation.nix

    ./hardware-configuration.nix
    ./system-apps.nix
  ];

  users.users.gregoire.uid = 1001;

  gregConfig.gnomeDesktop.enable = false;

  networking.hostName = "gregwork"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services.xserver.xkb = {
    layout = lib.mkForce "fr";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    tio
    saleae-logic-2
  ];

  hardware.saleae-logic.enable = true;
  users.users.gregoire.extraGroups = ["plugdev"];

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  hardware.bluetooth.powerOnBoot = false;
  networking.wireless.enable = lib.mkForce false;

  programs.nix-ld.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
