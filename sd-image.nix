{
  lib,
  pkgs,
  ...
}: {
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
    ./configuration.nix
  ];
  # nixpkgs.crossSystem.system = "aarch64-linux"; # the Pi
  # nixpkgs.localSystem.system = "x86_64-linux"; # your dev machine

  users.users.gregoire.hashedPassword = lib.fileContents ./secrets/initial_rpi_passwd;

  sdImage.compressImage = false; ## very long on aarch64 emulation
}
