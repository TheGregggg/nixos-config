{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.gregConfig.gnomeDesktop;
in {
  options.gregConfig.gnomeDesktop = with lib.options; {
    enable = mkEnableOption "Enable GNOME DE with my custom config";
    wallpaper = mkOption {
      description = "Path to the wallpaper";
      default = "/home/gregoire/nixos-config/home/themes/wallpaper/ayanami_purple.png";
    };
    dock-position = mkOption {
      type = lib.types.enum ["LEFT" "RIGHT" "BOTTOM" "TOP"];
      description = "Path to the wallpaper";
      default = "BOTTOM";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    services.flatpak.enable = true;

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

    environment.systemPackages = with pkgs.gnomeExtensions; [
      gsconnect
      vitals
      #open-bar
      no-overview
      #rounded-window-corners-reborn
      dash-to-dock
      appindicator
      tiling-shell
    ];

    # fixes some weird issues with file chooser on some apps
    environment.sessionVariables.XDG_DATA_DIRS = ["${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"];

    programs.kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };

    home-manager.users.gregoire = {
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
            picture-uri = "file://${cfg.wallpaper}";
            picture-uri-dark = "file://${cfg.wallpaper}";
            primary-color = "#000000000000";
            secondary-color = "#000000000000";
          };
          "org/gnome/desktop/screensaver" = {
            picture-uri = "file://${cfg.wallpaper}";
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
              #open-bar.extensionUuid
              no-overview.extensionUuid
              #rounded-window-corners-reborn.extensionUuid
              dash-to-dock.extensionUuid
              appindicator.extensionUuid
              tiling-shell.extensionUuid
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
            dock-position = cfg.dock-position;
          };
          "org/gnome/shell/extensions/appindicator" = {
            tray-pos = "left";
            icon-saturation = 1;
          };
          "org/blueman/plugins/powermanager" = {
            auto-power-on = false;
          };
        };
      };
    };

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    fonts.packages = with pkgs; [
      nerd-fonts._0xproto
      ipafont
      kochi-substitute
    ];
  };
}
