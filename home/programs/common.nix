{pkgs, ...}:
# Packages that should be installed to the user profile.
{
  home.packages = with pkgs; [
    #media
    vlc
    spotify

    libreoffice
    hunspell
    hunspellDicts.fr-moderne

    inkscape

    # apps
    discord
    transmission_4-gtk
    karere
    # signal-desktop
    pdfsam-basic
    nextcloud-client
    filezilla
    picard
    tigervnc

    # dev
    zig
    arduino-ide
    ghex
    foot
    lf

    jdk
    jetbrains.idea-oss

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf
    fastfetch
    btop

    texliveFull
    texstudio

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
  ];

  programs.git.enable = true;

  gregConfig.brave.enable = true;

  gregConfig.ydl.enable = true;

  gregConfig.nvim.enable = true;

  programs.vscodium = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default.extensions = with pkgs.vscode-extensions;
      [
        catppuccin.catppuccin-vsc
        kamadorueda.alejandra
        jeff-hykin.better-nix-syntax
        jnoortheen.nix-ide
        pkief.material-icon-theme
        llvm-vs-code-extensions.vscode-clangd
        ziglang.vscode-zig
        ms-python.python
        dbaeumer.vscode-eslint
        antyos.openscad
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "javascript-ejs-support";
          publisher = "DigitalBrainstem";
          version = "1.3.3";
          sha256 = "VvZ1CzgAbdYj10/j5lE5s88Rq3puqmYDfu1IcvRXXWg=";
        }
        {
          name = "nix-embedded-highlighter";
          publisher = "atomicspirit";
          version = "0.1.3";
          sha256 = "h864VdBXr9RTcFF++K0e6JcGWC2ffK0Phh2Zlqvzmro=";
        }
      ];
  };

  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Macchiato";
    settings = {
      font_family = "0xProto Nerd Font Mono";
    };
  };
}
