{pkgs, ...}: {
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

      # activate num lock at startup
      "org/gnome/desktop/peripherals/keyboard" = {
        numlock-state = true;
        remember-numlock-state = true;
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

      # extensions and dock settings
      "org/gnome/shell" = {
        favorite-apps = ["brave-browser.desktop" "org.gnome.Nautilus.desktop" "kitty.desktop" "codium.desktop"];
        disable-user-extensions = false; # enables user extensions
        enabled-extensions = with pkgs.gnomeExtensions; [
          gsconnect.extensionUuid
          vitals.extensionUuid
          open-bar.extensionUuid
          # no-overview.extensionUuid
          rounded-window-corners-reborn.extensionUuid
          dash-to-dock.extensionUuid
          appindicator.extensionUuid
        ];
      };

      #  vitals extensions settings
      "org/gnome/shell/extensions/vitals" = {
        hot-sensors = ["_memory_allocated_" "_temperature_processor_0_" "__fan_avg__" "_processor_frequency_"];
        position-in-panel = 2;
        fixed-widths = false;
      };

      # dash to dock settings
      "org/gnome/shell/extensions/dash-to-dock" = {
        dash-max-icon-size = 40;
        show-show-apps-button = true;
        show-trash = false;
        show-mounts = false;
        dance-urgent-applications = false;
        disable-overview-on-startup = true;
        custom-theme-shrink = false;
      };
      "org/gnome/shell/extensions/appindicator" = {
        tray-pos = "left";
      };
      "org/gnome/shell/extensions/appindicator" = {
        icon-saturation = 1;
      };

      "org/blueman/plugins/powermanager" = {
        auto-power-on = false;
      };
    };
  };
}
