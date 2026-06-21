# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./wolweb.nix
    # ./uptime_kuma.nix
  ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  hardware.graphics.enable = false;
  services.pipewire.enable = false;
  services.libinput.enable = false;

  nix.settings.trusted-users = ["root" "gregoire"];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "raspberry"; # Define your hostname.

  environment.systemPackages = with pkgs; [wireguard-tools];

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
