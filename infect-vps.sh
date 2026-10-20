#!/usr/bin/env bash

cd $(dirname $0)

nixpkgs_pin=$(nix eval --raw -f npins/default.nix nixpkgs)
export NIX_PATH="nixpkgs=${nixpkgs_pin}:nixos-config=${PWD}/configuration.nix"
export HOSTNAME=vps

toplevel=$(nixos-rebuild build --no-flake)
diskoScript=$(nix-build -E "((import <nixpkgs> {}).nixos [ ./configuration.nix ]).diskoScript")
nixos-anywhere --store-paths "$diskoScript" "$toplevel" root@gregoirelayet.com