#!/usr/bin/env bash

nixpkgs_pin=$(nix --extra-experimental-features nix-command eval --raw -f npins/default.nix nixpkgs)
nix_path="nixpkgs=${nixpkgs_pin}"

env NIX_PATH="${nix_path}" env HOSTNAME="rpi" nix-build '<nixpkgs/nixos>' -A config.system.build.sdImage -I nixos-config=./sd-image.nix --argstr system aarch64-linux