{
  pkgs,
  lib,
  config,
  ...
}: {
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

  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  ##### nix config
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true; # Optimize storage
      extra-platforms = ["aarch64-linux"];
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

  # Install firefox.
  programs.firefox.enable = true;

  hardware.keyboard.qmk.enable = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    curl
    wget
    git
    nil # nix lsp
    alejandra # nix formatter
    wireguard-tools

    # add dev manpage
    man-pages
    man-pages-posix
  ];

  #### Services

  # printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
    cups-pdf.enable = true; # enable virtual printer to print to pdf
  };

  #programs.adb.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [3000 5000];
  networking.firewall.allowedUDPPorts = [5000];

  networking.hosts = {
    "10.69.0.1" = ["mabbox.bytel.fr"];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
