#!/bin/bash

ffmpeg -i $(yt-dlp -f 18 --get-url https://www.youtube.com/watch?v=$1) -ss $2 -t $3 -c:v copy -c:a copy $1.mp4
ffmpeg -ss $2 -i $1.mp4 -pix_fmt rgb8 -r 10 -s "400x300" -t $3 $1-unoptimized.gif

# optimize the GIF with imagemagick
convert -layers Optimize $1-unoptimized.gif $1.gif
