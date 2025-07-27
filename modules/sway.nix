{pkgs, ...}: {
  programs.dconf.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --remember --cmd ${pkgs.sway}/bin/sway";
        user = "gregoire";
      };
    };
  };

  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    grim
    mako
    slurp
    wl-clipboard
  ];

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.waybar.enable = true;

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", SUBSYSTEM=="block", ACTION=="add", ENV{ID_FS_USAGE}=="filesystem", RUN+="${pkgs.writeShellScript "udev-mount.sh" ''
      ${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect --options=X-mount.mkdir "$DEVNAME" "/run/media/$ID_FS_LABEL"
    ''}"
    SUBSYSTEMS=="usb", SUBSYSTEM=="block", ACTION=="remove", ENV{ID_FS_USAGE}=="filesystem", RUN+="${pkgs.writeShellScript "udev-unmount.sh" ''
      ${pkgs.systemd}/bin/systemd-umount "$DEVNAME" "/run/media/$ID_FS_LABEL"
      ${pkgs.coreutils}/bin/rmdir "/run/media/$ID_FS_LABEL"
    ''}"
  '';
}
