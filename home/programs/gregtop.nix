{pkgs, ...}: {
  imports = [
    ./common.nix
    ./maker.nix
    ./gaming.nix
    ./switch.nix
  ];

  home.packages = with pkgs; [
    logseq
    clickup
  ];
}
