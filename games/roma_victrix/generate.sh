#!/bin/bash

dir="export/"

if [ -d "$dir" ]; then
    rm -r "$dir"
fi

mkdir -p "$dir"

objects=(
    cards_big
    cards_small

    counter_tray
    filler_tray
)

for i in "${objects[@]}"; do
    openscad --enable textmetrics -o export/$i.stl -D object=\"$i\" insert.scad
done