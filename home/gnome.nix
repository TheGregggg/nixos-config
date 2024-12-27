{pkgs, ...}: {
  home.file."/home/gregoire/.local/share/backgrounds/wallpaper.png".source = ../wallpaper.png; # set wallpaper image

  # gnome settings
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        accent-color = "purple";
        enable-hot-corners = false;
        show-battery-percentage = true;
      };

      # set wallpaper - a lot of line because I just copy what the settings do to the dconf db
      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/gregoire/.local/share/backgrounds/wallpaper.png";
        picture-uri-dark = "file:///home/gregoire/.local/share/backgrounds/wallpaper.png";
        primary-color = "#000000000000";
        secondary-color = "#000000000000";
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file:///home/gregoire/.local/share/backgrounds/wallpaper.png";
        primary-color = "#000000000000";
        secondary-color = "#000000000000";
      };

      # extensions settings
      "org/gnome/shell" = {
        disable-user-extensions = false; # enables user extensions
        enabled-extensions = [
          pkgs.gnomeExtensions.gsconnect.extensionUuid
          pkgs.gnomeExtensions.vitals.extensionUuid
          pkgs.gnomeExtensions.open-bar.extensionUuid
        ];
      };
    };
  };
}
