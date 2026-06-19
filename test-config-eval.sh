for config in gregtop gregwork gregpc; do
    nixos-rebuild --no-reexec dry-run --flake ".#${config}"
done