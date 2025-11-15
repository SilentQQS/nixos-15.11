#!/usr/bin/env bash

mkdir -p /tmp/recordings "$HOME/Videos/recordings"

while true; do
  filename="segment_$(date +%Y%m%d_%H%M%S).mkv"
  tmpfile="/tmp/recordings/$filename"
  diskfile="$HOME/Videos/recordings/$filename"

  echo "🎥 Record $filename..."
  sudo ffmpeg -hide_banner -loglevel error \
    -f kmsgrab -framerate 60 -device /dev/dri/card2 -i - \
    -vf "hwmap=derive_device=vaapi,crop=x=0:y=0:w=1920:h=1080,scale_vaapi=1280:720:nv12" \
    -c:v hevc_vaapi -qp 37 -g 300 -bf 2 -t 10 -y "$tmpfile"

  echo "💾 Перемещение $filename на диск..."
  mv "$tmpfile" "$diskfile"
done

