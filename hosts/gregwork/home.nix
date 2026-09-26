{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # dev
    clang-tools
    binwalk

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    fzf

    shfmt
    shellcheck

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

  programs.git = rec {
    enable = true;
    settings.user.email = lib.mkForce "gregoire.layet2@microchip.com";
    signing.key = lib.mkForce "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
  };

  gregConfig.nvim.enable = true;
}
