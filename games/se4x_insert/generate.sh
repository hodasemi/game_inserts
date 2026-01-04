#!/bin/bash

dir="export/"

if [ -d "$dir" ]; then
    rm -r "$dir"
fi

mkdir -p "$dir"

objects=(
    card_tray_1
    card_tray_2
    hex_area

    card_tray_filler
    bottom_spacer
    hex_filler_1
    hex_filler_2
    inter_hex_filler
    top_spacer

    base_empire
    alternate_empire
    replicator
)

for i in "${objects[@]}"; do
    openscad --enable textmetrics -o export/$i.stl -D object=\"$i\" big_box.scad
done