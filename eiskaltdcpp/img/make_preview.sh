#!/bin/sh

for i in *.png
do
  echo "Working on $i ..."
  convert -resize 150 -quality 90 "$i" "preview/$i" 2> /dev/null
done

