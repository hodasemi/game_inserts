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

unit_card_width = 95;
unit_card_height = 137;

wall_thickness = 2 * nozzle_diameter;

module upper_right_cards() {
  upper_right_card_width = 2 * (sleeve_width + sleeve_tolerance) + 3 * wall_thickness;
  upper_right_card_height = sleeve_height + sleeve_tolerance + 2 * wall_thickness;

  translate([box_width - upper_right_card_height, box_height, 0])
    rotate(-90, [0, 0, 1])
      chit_storage(
        chit_size=[sleeve_width, sleeve_height],
        chit_tolerance=sleeve_tolerance,
        chit_thickness=sleeve_thickness,
        wall_thickness=wall_thickness,
        front_wall_thickness=wall_thickness,
        width=upper_right_card_width,
        height=upper_right_card_height,
        depth=box_depth,
        columns=2,
        chit_count_per_slot=floor((box_depth - 1.0) / sleeve_thickness),
        front_wall_width=sleeve_width / 4,
      );
}

module unit_cards() {
  thickness = 1;

  soviet_depth = box_depth * 3 / 5;
  nato_depth = box_depth * 2 / 5;

  unit_width = unit_card_width + 2 * wall_thickness + sleeve_tolerance;
  unit_height = unit_card_height + 2 * wall_thickness + sleeve_tolerance;

  translate([0, box_height - unit_height, 0]) {
    chit_storage(
      chit_size=[unit_card_width, unit_card_height],
      chit_tolerance=sleeve_tolerance,
      chit_thickness=thickness,
      wall_thickness=wall_thickness,
      front_wall_thickness=wall_thickness,
      width=unit_width,
      height=unit_height,
      depth=soviet_depth,
      columns=1,
      chit_count_per_slot=floor((soviet_depth - 1.0) / thickness),
      front_wall_width=unit_card_width / 4,
    );

    translate([0, 0, soviet_depth])
      chit_storage(
        chit_size=[unit_card_width, unit_card_height],
        chit_tolerance=sleeve_tolerance,
        chit_thickness=thickness,
        wall_thickness=wall_thickness,
        front_wall_thickness=wall_thickness,
        width=unit_width,
        height=unit_height,
        depth=nato_depth,
        columns=1,
        chit_count_per_slot=floor((nato_depth - 1.5) / thickness),
        front_wall_width=unit_card_width / 4,
      );
  }
}

upper_right_cards();
unit_cards();

color("green", 0.3) cube([box_width, box_height, box_depth]);
