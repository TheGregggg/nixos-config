{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lutris
    bottles
    gsettings-desktop-schemas
    gtk3
  ];

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
}
