use <../../shared/chit_storage.scad>

inch = 25.4;
nozzle_diameter = 0.6;

width = 210;
height = 275;
depth = 83;

box_wall = 3;
other_content = 35;

box_width = width - 2 * box_wall;
box_height = height - 2 * box_wall;
box_depth = depth - other_content;

sleeve_width = 66.5;
sleeve_height = 92.5;
sleeve_tolerance = 2;
sleeve_thickness = 0.72;

wall_thickness = 2 * nozzle_diameter;

chit_storage(
  chit_size=[sleeve_width, sleeve_height],
  chit_tolerance=sleeve_tolerance,
  chit_thickness=sleeve_thickness,
  wall_thickness=wall_thickness,
  front_wall_thickness=wall_thickness,
  width=2 * (sleeve_width + sleeve_tolerance) + 3 * wall_thickness,
  height=sleeve_height + sleeve_tolerance + 2 * wall_thickness,
  depth=box_depth,
  columns=2,
  chit_count_per_slot=floor((box_depth - 1.0) / sleeve_thickness),
  front_wall_width=sleeve_width / 4,
);

color("green", 0.3) cube([box_width, box_height, box_depth]);
