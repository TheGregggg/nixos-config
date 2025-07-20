nix-shell -p git  && sudo nixos-rebuild  --experimental-features 'nix-command flakes' switch --flake '.#gregpc'

rm -r /etc/nixos
ln -s /home/gregoire/nixos-config /etc/nixos
