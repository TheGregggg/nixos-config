#!/usr/bin/env bash
RPI_IP="192.168.1.127"

echo "Pushing configuration to host"
rsync -ax --exclude "/result" --exclude "/old/" ./ gregoire@$RPI_IP:/home/gregoire/nixos
