{
  modulesPath,
  pkgs,
  ...
}: let
  sources = import ../../npins;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (sources.disko + "/module.nix")
    (sources.agenix + "/modules/age.nix")
    ./hardware-configuration.nix
    ./disk-config.nix
    ./caddy.nix
    ./vaultwarden.nix
  ];
  # Disabling the whole `profiles/base.nix` module, which is responsible
  # for adding ZFS and a bunch of other unnecessary programs:
  disabledModules = [
    "profiles/base.nix"
  ];

  disko.devices.disk.main.device = "/dev/sda";

  boot.loader.grub = {
    enable = true;
    devices = ["/dev/sda"];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  boot.loader.efi = {
    efiSysMountPoint = "/boot/efi";
    canTouchEfiVariables = false;
  };

  nix.settings.trusted-users = ["root" "gregoire"];

  networking.networkmanager.enable = true;

  networking = {
    hostName = "vps";
    interfaces.eth0 = {
      ipv4.addresses = [
        {
          address = "185.157.245.210";
          prefixLength = 25;
        }
      ];
      ipv6.addresses = [
        {
          address = "2a09:6383:0:10:185:157:245:210";
          prefixLength = 64;
        }
      ];
    };
    defaultGateway = {
      address = "185.157.245.129";
      interface = "eth0";
    };

    defaultGateway6 = {
      address = "2a09:6383:0:10::1";
      interface = "eth0";
    };

    nameservers = [
      "45.147.98.3"
      "89.234.180.34"
      "2a09:6383::45:147:98:3"
      "2a09:6382::2"
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = ["gregoire"];
    };
  };

  age.secrets.vaultwardenEnv.file = ./secrets/vaultwarden.age;

  users.users.gregoire.initialPassword = "gregoire";

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
