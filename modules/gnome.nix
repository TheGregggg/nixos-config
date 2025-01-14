{
  pkgs,
  lib,
  ...
}: {
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  #exclude unused packages
  environment.gnome.excludePackages = with pkgs; [
    cheese # photo booth
    epiphany # web browser
    gedit # text editor
    simple-scan # document scanner
    totem # video player
    yelp # help viewer

    gnome-contacts
    gnome-weather
    gnome-connections
  ];

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs.gnomeExtensions; [
    gsconnect
    vitals
    open-bar
    no-overview
    rounded-window-corners-reborn
    #pop-shell
    # ...
  ];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  systemd.services.numLockOnTty = {
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      # /run/current-system/sw/bin/setleds -D +num < "$tty";
      ExecStart = lib.mkForce (pkgs.writeShellScript "numLockOnTty" ''
        for tty in /dev/tty{1..6}; do
            ${pkgs.kbd}/bin/setleds -D +num < "$tty";
        done
      '');
    };
  };
}
