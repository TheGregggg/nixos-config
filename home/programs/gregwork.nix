{
  pkgs,
  config,
  lib,
  ...
}: let
  open-remote-ssh = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "jeanp413";
      name = "open-remote-ssh";
      version = "0.0.49";
    };
    vsix = pkgs.fetchurl {
      url = "https://open-vsx.org/api/jeanp413/open-remote-ssh/0.0.49/file/jeanp413.open-remote-ssh-0.0.49.vsix";
      # set to lib.fakeHash on first build, paste the real one from the error
      hash = "sha256-QfJnAAx+kO2iJ1EzWoO5HLogJKg3RiC3hg1/u2Jm6t4=";
      name = "jeanp413-open-remote-ssh.zip";
    };
  };
in {
  home.packages = with pkgs; [
    libreoffice
    hunspell
    hunspellDicts.fr-moderne

    inkscape

    slack
    discord
    aerc

    # apps
    pdfsam-basic
    filezilla

    # dev
    ghex
    clang-tools

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf
    starship
    fastfetch
    btop
    wineWow64Packages.stable

    texliveFull
    texstudio

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

  # basic configuration of git, please change to your own
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "yes";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
  };

  programs.git = rec {
    enable = true;
    settings.user.email = lib.mkForce "gregoire.layet@9elements.com";
    signing.key = lib.mkForce "${config.home.homeDirectory}/.ssh/id_ecdsa.pub";
    settings = {
      sendemail = {
        from = "${settings.user.name} <${settings.user.email}>";
        smtpuser = "${settings.user.email}";
        smtpserver = "smtp.gmail.com";
        smtpencryption = "ssl";
        smtpserverport = 465;
        chainreplyto = false;
        tocover = true;
        cccover = true;
        linux = {
          tocmd = "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nol";
          cccmd = "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nom";
        };
      };
    };
  };

  programs.brave = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
      {id = "cmpdlhmnmjhihmcfnigoememnffkimlk";} # Catppuccin Macchiato
    ];
    commandLineArgs = ["--password-store=gnome-libsecret"];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhs;
    mutableExtensionsDir = true;
    # profiles.default.extensions = with pkgs.vscode-extensions;
    #   [
    #     catppuccin.catppuccin-vsc
    #     kamadorueda.alejandra
    #     jeff-hykin.better-nix-syntax
    #     jnoortheen.nix-ide
    #     pkief.material-icon-theme
    #     llvm-vs-code-extensions.vscode-clangd
    #     ziglang.vscode-zig
    #     ms-python.python
    #     dbaeumer.vscode-eslint
    #     open-remote-ssh
    #   ]
    #   ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    #     {
    #       name = "javascript-ejs-support";
    #       publisher = "DigitalBrainstem";
    #       version = "1.3.3";
    #       sha256 = "VvZ1CzgAbdYj10/j5lE5s88Rq3puqmYDfu1IcvRXXWg=";
    #     }
    #     {
    #       name = "yocto-bitbake";
    #       publisher = "yocto-project";
    #       version = "2.8.0";
    #       sha256 = "FCgZ3yG4WQGTxJ6Z9AFRycX7owUU9/1xrNzC1WjzvgA=";
    #     }
    #   ];
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      HISTCONTROL=ignoreboth

      eval "$(starship init bash)"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      ll = "ls -alh";
      vi = "nvim";
      nrs = "sudo nixos-rebuild switch --no-reexec";
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
