{gregcomputer, ...}: {
  imports = [
    ./common.nix
    ./maker.nix
    (./. + "/${gregcomputer}.nix")
  ];
}
