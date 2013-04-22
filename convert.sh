#!/bin/sh


mkdir -p border

for f in *.png
do
  convert $f \
    -resize '500x' \
    -bordercolor grey \
    -border 5x5 \
    border/$f
done
