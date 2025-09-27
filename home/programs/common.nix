{pkgs, ...}: {
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    #media
    vlc
    spotify

    libreoffice
    hunspell
    hunspellDicts.fr-moderne

    # apps
    discord
    transmission_4-gtk
    whatsapp-for-linux
    pdfsam-basic
    nextcloud-client
    filezilla
    picard

    # dev
    zig
    arduino-ide
    ghex

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf
    starship
    fastfetch
    btop
    wineWowPackages.stable

    nmap

    # misc
    cowsay
    which

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

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
      {id = "cmpdlhmnmjhihmcfnigoememnffkimlk";} # Catppuccin Macchiato
    ];
    commandLineArgs = ["--password-store=gnome-libsecret"];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
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
      vi = "nvim";
      nrs = "sudo nixos-rebuild switch";
      gcm = "git commit -m";
    };
  };

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Macchiato";
    settings = {
      font_family = "0xProto Nerd Font Mono";
    };
  };

  programs.neovim = {
    enable = true;
  };
}
