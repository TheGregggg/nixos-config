{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-screenshot
    nicotine-plus
  ];
}
