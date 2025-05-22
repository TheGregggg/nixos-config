{gregcomputer, ...}: {
  imports = [
    ./common.nix
    (./. + "/${gregcomputer}.nix")
  ];
}
