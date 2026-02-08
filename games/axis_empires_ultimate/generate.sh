#!/bin/bash

dir="export/"

if [ -d "$dir" ]; then
    rm -r "$dir"
fi

mkdir -p "$dir"

objects=(
    first_row_cards
    second_row_cards
    counter_tray

    spacer
)

for i in "${objects[@]}"; do
    openscad --enable textmetrics -o export/$i.stl -D object=\"$i\" insert.scad
done