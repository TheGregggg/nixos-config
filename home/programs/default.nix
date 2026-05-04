{gregcomputer, ...}: {
  imports = [
    ./common.nix
    ./maker.nix
    ./gaming.nix
    ./switch.nix
    (./. + "/${gregcomputer}.nix")
  ];
}
