# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    ../../modules/system.nix
    ../../modules/sway.nix
    #../../modules/podman.nix
    #../../modules/numlock.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader config
  boot.loader = {
    systemd-boot.enable = false;

    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      configurationLimit = 10; # Limit the number of generations to keep
      theme = pkgs.stdenv.mkDerivation {
        pname = "CyberGRUB-2077";
        version = "1";
        src = pkgs.fetchFromGitHub {
          owner = "TheGregggg";
          repo = "CyberGRUB-2077";
          rev = "f95fa64b062e8d965385cc0ca89abd1970b19742";
          hash = "sha256-IqSzQ4UPpxX7oMfuOdgcSj6rUNjsrXJVGnLhvbbOMVk=";
        };
        installPhase = ''
          runHook preInstall

          mkdir -p $out/

          cp -r CyberGRUB-2077/* $out/

          runHook postInstall
        '';
      };
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  networking.hostName = "gregtop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.bluetooth.powerOnBoot = false;

  #ncfg.services.numlock-on-tty.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
