{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-screenshot
    nicotine-plus
    lmms

    audacity
    kdePackages.kdenlive
    gsettings-desktop-schemas

    prismlauncher

    (heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
      ];
    })

    wineWowPackages.stable
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
