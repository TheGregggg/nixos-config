# Default config for ALL systems
# define nix config
# define time zone
{pkgs, ...}: {
  ##### User config
  users.users.gregoire = {
    isNormalUser = true;
    description = "gregoire";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout" # Allow access to serial device (for Arduino dev)
    ];
  };

  ##### nix config
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };

    gc = {
      # Perform garbage collection weekly to maintain low disk usage
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  ##### i18n config
  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  #### Apps and packages
  environment.systemPackages = with pkgs; [
    vim
    curl
    wget
  ];
}
