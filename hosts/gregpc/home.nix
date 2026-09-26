{pkgs, ...}: {
  imports = [
    ../../home/programs/common.nix
    ../../home/programs/maker.nix
    ../../home/programs/gaming.nix
    ../../home/programs/switch.nix
  ];

  home.packages = with pkgs; [
    gnome-screenshot
    nicotine-plus
    lmms

    audacity
    kdePackages.kdenlive
    gsettings-desktop-schemas

    prismlauncher

    cemu
    ryubing

    (heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
      ];
    })

    wineWow64Packages.stable
    winetricks
  ];

  programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };
}
