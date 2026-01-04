#!/bin/bash

dir="export/"

if [ -d "$dir" ]; then
    rm -r "$dir"
fi

mkdir -p "$dir"

objects=(
    snafu
    objectives
    hasty_meeting
    prepared_deliberate

    storage
    filler
    spacer
)

for i in "${objects[@]}"; do
    openscad --enable textmetrics -o export/$i.stl -D object=\"$i\" insert.scad
done