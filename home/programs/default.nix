{hostname, ...}: {
  imports = [
    ./shell.nix
    ./browser.nix
    ./git.nix
    ./ydl.nix
    (./. + "/${hostname}.nix")
  ];
}
