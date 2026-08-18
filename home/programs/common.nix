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
    signal-desktop
    pdfsam-basic
    nextcloud-client
    filezilla
    picard
    thunderbird

    # dev
    zig
    arduino-ide

    # OSS
    b4

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf
    parallel
    shfmt
    shellcheck
    lf
    binwalk

    foot

    texliveFull
    texstudio
    ltex-ls-plus

    #netwoking
    nmap
    arp-scan

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
        ltex-plus.vscode-ltex-plus
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
        {
          name = "latex-workshop";
          publisher = "James-Yu";
          version = "10.18.0";
          sha256 = "nuBx5ujJPbKvXRvIbUaPaIgoUeeYp4XwHwOdAjCVqUY=";
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

  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.resistFingerprinting.letterboxing" = true;
    };
    profiles.gregoire = {
      settings = {
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        "extensions.autoDisableScopes" = 0; #auto enable extensions
      };
    };
  };
}
