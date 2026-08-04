#! /usr/bin/env nix-shell
#! nix-shell -i bash -p ffmpeg parallel
set -e

find ./sources/ -type f  \( -name "*.flac" -o -name "*.wav" -o -name "*.mp3" -o -name "*.m4u" \) -print0 |
parallel --bar -0 '
file={}
d=$(dirname "$file")
d=${d/#*sources/.} # remove sources/ at begining of path : ./sources/ -> ./
b=$(basename "$file")

mkdir -p "Ziq/$d"

ext=${b#*.}
dest="Ziq/$d/${b%.*}.mp3"

if [ -f "$dest" ]; then
    exit 0
fi

if [ "$ext" != "mp3" ]; then
ffmpeg -hide_banner -loglevel error -nostdin -threads 1 -i "$file" \
    -c:v copy -b:a 320k -map_metadata 0 -id3v2_version 3 \
    "$dest"
else
    cp "$file" "$dest"
fi
'
