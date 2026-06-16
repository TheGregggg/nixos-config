{hostname, ...}: {
  imports = [
    ./browser.nix
    (./. + "/${hostname}.nix")
  ];
}
