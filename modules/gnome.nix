{pkgs, ...}: {
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  #exclude unused packages
  services.xserver.excludePackages = [pkgs.xterm];

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
    gnome-tour
  ];

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs.gnomeExtensions; [
    gsconnect
    vitals
    open-bar
    no-overview
    rounded-window-corners-reborn
    dash-to-dock
    appindicator
    #pop-shell
    # ...
  ];

  environment.sessionVariables.XDG_DATA_DIRS = ["${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"];

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
