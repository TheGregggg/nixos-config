{hostname, ...}: {
  imports = [
    ./config.nix
    (./. + "/${hostname}.nix")
  ];
}
