{pkgs, ...}: {
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    thunderbird
    brave

    vlc

    libreoffice
    hunspell
    hunspellDicts.fr-moderne

    discord

    transmission_4

    kitty

    fastfetch

    # dev
    zig

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder

    # networking tools
    nmap # A utility for network discovery and security auditing

    # misc
    cowsay
    which

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    btop # replacement of htop/nmon

    # system tools
    lm_sensors
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Grégoire Layet";
    userEmail = "git@gregoirelayet.com";
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      mvllow.rose-pine
      kamadorueda.alejandra
      jeff-hykin.better-nix-syntax
      jnoortheen.nix-ide
      pkief.material-icon-theme
    ];
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      ll = "ls -alh";
    };
  };
}
