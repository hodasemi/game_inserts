#!/bin/bash

dir="export/"

if [ -d "$dir" ]; then
    rm -r "$dir"
fi

mkdir -p "$dir"

objects=(
    upper_right_cards
    upper_left_cards
    nato_unit_cards
    russian_unit_cards
    event_cards
    extra_cards

    faction_counter
    general_counter

    cube_tray
    filler
)

for i in "${objects[@]}"; do
    openscad --enable textmetrics -o export/$i.stl -D object=\"$i\" insert.scad
done