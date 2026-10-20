{pkgs, ...}: {
  home.packages = with pkgs; [
    jdk
    jetbrains.idea-oss
  ];
}
