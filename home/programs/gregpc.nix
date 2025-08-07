{pkgs, ...}: {
  imports = [
    ../themes/evangelions.nix
  ];

  home.packages = with pkgs; [
    gnome-screenshot

    steam
  ];
}
