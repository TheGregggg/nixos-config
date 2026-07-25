#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

# assume that if there are no args, you want to switch to the configuration
cmd=${1:-switch}
shift

nixpkgs_pin=$(nix --extra-experimental-features nix-command eval --raw -f npins/default.nix nixpkgs)
nix_path="nixpkgs=${nixpkgs_pin}:nixos-config=${PWD}/configuration.nix"

echo "rebuild here switch on vps"
env NIX_PATH="${nix_path}" env HOSTNAME="vps" nixos-rebuild "$cmd" --no-flake -I nixos-config=./configuration.nix --target-host gregoire@gregoirelayet.com --sudo --ask-sudo-password --no-reexec "$@"
