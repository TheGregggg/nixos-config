{gregcomputer, ...}: {
  imports = [
    ./config.nix
    (./. + "/${gregcomputer}.nix")
  ];
}
