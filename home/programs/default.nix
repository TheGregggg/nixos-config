{gregcomputer, ...}: {
  imports = [
    ./common.nix
    ./maker.nix
    ./gaming.nix
    (./. + "/${gregcomputer}.nix")
  ];
}
