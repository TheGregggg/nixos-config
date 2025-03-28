{
  pkgs,
  lib,
  ...
}: {
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    vlc
    nextcloud-client

    libreoffice
    hunspell
    hunspellDicts.fr-moderne

    discord

    transmission_4-gtk

    spotify

    wineWowPackages.stable

    fastfetch

    whatsapp-for-linux
    pdfsam-basic

    # dev
    zig

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    starship

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

    yt-dlp
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Grégoire Layet";
    userEmail = "git@gregoirelayet.com";
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
      {id = "nnghgmgfiemkbmbfdiacfceanmpdgbcd";} # Gestnote Ranking
      {id = "noimedcjdohhokijigpfcbjcfcaaahej";} # RosePine
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      mvllow.rose-pine
      kamadorueda.alejandra
      jeff-hykin.better-nix-syntax
      jnoortheen.nix-ide
      pkief.material-icon-theme
      llvm-vs-code-extensions.vscode-clangd
      ziglang.vscode-zig
    ];
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      HISTCONTROL=ignoreboth

      ydl(){
        yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 320k -o "%(title)s.%(ext)s" "$1"
      }

      eval "$(starship init bash)"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      ll = "ls -alh";
    };
  };

  programs.kitty = {
    enable = true;
    themeFile = "rose-pine";
    settings = {
      font_family = "0xProto Nerd Font Mono";
    };
  };

  programs.neovim = {
    enable = true;
    extraConfig = lib.fileContents ~/.config/nvim/init.vim;
  };
}
