{
  modulesPath,
  lib,
  pkgs,
  ...
}: let
  sources = import ../../npins;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/perlless.nix")
    (sources.disko + "/module.nix")
    ./hardware-configuration.nix
    ./disk-config.nix
  ];
  # Disabling the whole `profiles/base.nix` module, which is responsible
  # for adding ZFS and a bunch of other unnecessary programs:
  disabledModules = [
    "profiles/base.nix"
  ];

  boot.loader.systemd-boot = {
    enable = true;
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix.settings.trusted-users = ["root" "gregoire"];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = ["gregoire"];
    };
  };

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    fastfetch.minimal
    rsync
  ];

  users.users.gregoire.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSrvedYY5OobcIQbWvsPR+Nxkasj2ggkcTYK64h924/ gregoire@gregtop"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBwjSqSHUlTcMh/CCDcmM4bkAL6ktBS7lxQ6M3wSgLcU gregoire@gregpc"
  ];

  system.stateVersion = "26.05";
}
