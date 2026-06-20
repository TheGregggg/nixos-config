{pkgs, ...}: {
  imports = [
    ../../home/programs/common.nix
    ../../home/programs/maker.nix
    ../../home/programs/gaming.nix
    ../../home/programs/switch.nix
  ];

  home.packages = with pkgs; [
    # logseq
    clickup
    st
  ];
}
