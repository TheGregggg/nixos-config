{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-screenshot
    nicotine-plus
    lmms

    prismlauncher

    (heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
      ];
    })

    wineWowPackages.stable
    winetricks
  ];
}
