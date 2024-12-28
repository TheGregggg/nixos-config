{pkgs, ...}: {
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

  environment.systemPackages = with pkgs.gnomeExtensions; [
    gsconnect
    vitals
    open-bar
    no-overview
    #pop-shell
    # ...
  ];
}
