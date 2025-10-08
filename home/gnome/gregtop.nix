{...}: {
  # gnome settings
  dconf = {
    enable = true;
    settings = {
      # dash to dock settings
      "org/gnome/shell/extensions/dash-to-dock" = {
        dock-position = "LEFT";
      };
    };
  };
}
