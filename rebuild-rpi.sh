#!/usr/bin/env bash
RPI_IP="192.168.1.127"

cd "$(dirname "$0")" || exit

# assume that if there are no args, you want to switch to the configuration
cmd=${1:-switch}
shift

nixpkgs_pin=$(nix --extra-experimental-features nix-command eval --raw -f npins/default.nix nixpkgs)
nix_path="nixpkgs=${nixpkgs_pin}:nixos-config=${PWD}/configuration.nix"

echo "Pushing secrets to rpi"
ssh gregoire@$RPI_IP mkdir -p /home/gregoire/nixos
rsync -ax --delete ./hosts/rpi/wireguard/ gregoire@$RPI_IP:/home/gregoire/nixos/

echo "rebuild here and switch on rpi"
env NIX_PATH="${nix_path}" env HOSTNAME="rpi" nixos-rebuild "$cmd" --no-flake -I nixos-config=./configuration.nix --target-host gregoire@$RPI_IP --sudo --ask-sudo-password --no-reexec "$@"
