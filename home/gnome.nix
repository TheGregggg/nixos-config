{...}: {
  home.file."/home/gregoire/.local/share/backgrounds/wallpaper.png".source = ../wallpaper.png; # set wallpaper

  # gnome settings
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "purple";
      enable-hot-corners = false;
      show-battery-percentage = true;
    };

    # set wallpaper - a lot of line because I just copy what the settings do to the dconf db
    settings."org/gnome/desktop/background" = {
      picture-uri = "file:///home/gregoire/.local/share/backgrounds/wallpaper.png";
      picture-uri-dark = "file:///home/gregoire/.local/share/backgrounds/wallpaper.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    settings."org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/gregoire/.local/share/backgrounds/wallpaper.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
  };
}
