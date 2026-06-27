# config for all workstation
{pkgs, ...}: {
  # cross compile tools
  boot.binfmt.emulatedSystems = ["aarch64-linux"];
  nix.settings.extra-platforms = ["aarch64-linux"];

  users.users.gregoire.extraGroups = ["dialout"]; # Allow access to serial device (for Arduino dev)

  environment.systemPackages = with pkgs; [
    git
    nil # nix lsp
    alejandra # nix formatter
    wireguard-tools
    fastfetch

    # add dev manpage
    man-pages
    man-pages-posix

    npins
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
}
