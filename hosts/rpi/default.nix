{
  pkgs,
  lib,
  ...
}: let
  sources = import ../../npins;
in {
  imports = [
    <nixpkgs/nixos/modules/profiles/minimal.nix>
    <nixpkgs/nixos/modules/profiles/perlless.nix> ## -1 GB
    ./hardware-configuration.nix
    ./networking.nix
    ./wolweb.nix
    # ./uptime_kuma.nix
  ];

  # Disabling the whole `profiles/base.nix` module, which is responsible
  # for adding ZFS and a bunch of other unnecessary programs:
  disabledModules = [
    "profiles/base.nix"
  ];

  # Kills the 789 MB linux-firmware bundle + sof-firmware + wireless-regdb.
  hardware.enableRedistributableFirmware = lib.mkForce false;
  hardware.enableAllFirmware = false;

  # ONLY if you use the Pi's onboard Wi-Fi / Bluetooth, add the brcm blobs back
  # (a few MB, not the 789 MB set). Ethernet-only? Delete this line entirely.
  # hardware.firmware = [pkgs.raspberrypiWirelessFirmware];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  boot.tmp.useTmpfs = true;

  hardware.graphics.enable = false;
  services.pipewire.enable = false;
  services.libinput.enable = false;

  nix.settings.trusted-users = ["root" "gregoire"];
  nix.gc.automatic = lib.mkForce false;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "raspberry"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    wireguard-tools
    fastfetch.minimal
    rsync
  ];

  # Enable SSH in the boot process.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = ["gregoire"];
    };
  };
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];

  users.users.gregoire = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSrvedYY5OobcIQbWvsPR+Nxkasj2ggkcTYK64h924/ gregoire@gregtop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBwjSqSHUlTcMh/CCDcmM4bkAL6ktBS7lxQ6M3wSgLcU gregoire@gregpc"
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
