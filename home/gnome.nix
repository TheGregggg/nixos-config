{...}: {
  # gnome settings
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "purple";
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
  };
}
