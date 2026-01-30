use <../../shared/chit_storage.scad>
use <../../shared/general_storage.scad>

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

unit_tolerance = 2 * sleeve_tolerance;

unit_width = unit_card_width + 2 * wall_thickness + unit_tolerance;
unit_height = unit_card_height + 2 * wall_thickness + unit_tolerance;

extra_cards_width = sleeve_width + 2 * wall_thickness + sleeve_thickness;
event_card_depth = 15;

chit_size = 9 / 16 * inch;
chit_tolerance = 1;
chit_thickness = 2;

module upper_right_cards() {
  // upper_right_card_width = 2 * (sleeve_width + sleeve_tolerance) + 3 * wall_thickness;
  upper_right_card_width = unit_height;
  // upper_right_card_height = sleeve_height + sleeve_tolerance + 2 * wall_thickness;
  upper_right_card_height = box_width - unit_width;

  translate([box_width - upper_right_card_height, box_height, 0])
    rotate(-90, [0, 0, 1])
      chit_storage(
        chit_size=[sleeve_width, sleeve_height],
        chit_tolerance=sleeve_tolerance,
        chit_thickness=sleeve_thickness,
        wall_thickness=wall_thickness,
        front_wall_thickness=4,
        width=upper_right_card_width,
        height=upper_right_card_height,
        depth=box_depth,
        columns=2,
        chit_count_per_slot=floor((box_depth - 2.0) / sleeve_thickness),
        front_wall_width=sleeve_width / 4,
      );
}

module unit_cards(upper, lower) {
  thickness = 1;

  soviet_depth = box_depth * 3 / 5 - 1.5;
  nato_depth = box_depth * 2 / 5 + 1.5;

  translate([0, box_height - unit_height, 0]) {

    if (lower)
      chit_storage(
        chit_size=[unit_card_width, unit_card_height],
        chit_tolerance=unit_tolerance,
        chit_thickness=thickness,
        wall_thickness=wall_thickness,
        front_wall_thickness=wall_thickness,
        width=unit_width,
        height=unit_height,
        depth=soviet_depth,
        columns=1,
        chit_count_per_slot=floor((soviet_depth - 2.0) / thickness),
        front_wall_width=unit_card_width / 4,
      );

    if (upper)
      translate([0, 0, soviet_depth])
        chit_storage(
          chit_size=[unit_card_width, unit_card_height],
          chit_tolerance=unit_tolerance,
          chit_thickness=thickness,
          wall_thickness=wall_thickness,
          front_wall_thickness=wall_thickness,
          width=unit_width,
          height=unit_height,
          depth=nato_depth,
          columns=1,
          chit_count_per_slot=floor((nato_depth - 2.5) / thickness),
          front_wall_width=unit_card_width / 4,
        );
  }
}

module event_cards() {
  translate([box_width / 2, 0, 0])
    rotate(90, [0, 0, 1])
      chit_storage(
        chit_size=[sleeve_width, sleeve_height],
        chit_tolerance=sleeve_tolerance,
        chit_thickness=sleeve_thickness,
        wall_thickness=wall_thickness,
        front_wall_thickness=4,
        width=extra_cards_width,
        height=box_width / 2,
        depth=event_card_depth,
        columns=1,
        chit_count_per_slot=floor((event_card_depth - 1.5) / sleeve_thickness),
        front_wall_width=sleeve_width / 4,
      );
}

module extra_cards() {
  chit_storage(
    chit_size=[sleeve_width, sleeve_height],
    chit_tolerance=sleeve_tolerance,
    chit_thickness=sleeve_thickness,
    wall_thickness=wall_thickness,
    front_wall_thickness=4,
    width=extra_cards_width,
    height=box_width / 2,
    depth=box_depth - event_card_depth,
    columns=1,
    chit_count_per_slot=floor((box_depth - event_card_depth - 1.5) / sleeve_thickness),
    front_wall_width=sleeve_width / 4,
  );
}

counter_width = box_height - unit_height - extra_cards_width;
counter_height = 3 * wall_thickness + 2 * (chit_size + chit_tolerance);

module faction_counters() {
  translate([2 * counter_height, extra_cards_width, 0])
    rotate(90, [0, 0, 1])
      fill_storage_space(
        chit_size=chit_size,
        chit_tolerance=chit_tolerance,
        chit_thickness=chit_thickness,
        wall_thickness=wall_thickness,
        front_wall_thickness=wall_thickness,
        fill_parameter=[
          [counter_width, 1],
          [2 * counter_height, 2],
          [box_depth, 4],
        ],
        single_for_printing=false,
      );
}

module general_counter(single) {
  height = 2 * wall_thickness + (chit_size + chit_tolerance);

  for (i = [0:3]) {
    if (single && i == 0 || !single) {
      translate([2 * counter_height + height, extra_cards_width, i * box_depth / 4])
        rotate(90, [0, 0, 1])
          chit_storage(
            chit_size=chit_size,
            chit_tolerance=chit_tolerance,
            chit_thickness=chit_thickness,
            wall_thickness=wall_thickness,
            front_wall_thickness=wall_thickness,
            width=counter_width,
            height=height,
            depth=box_depth / 4,
            columns=3,
            chit_count_per_slot=5,
          );
    }
  }
}

upper_right_cards();
unit_cards(true, true);
event_cards();

// soviet
translate([box_width / 2, 0, event_card_depth])
  rotate(90, [0, 0, 1])
    extra_cards();

// nato
translate([box_width / 2, sleeve_width + 2 * wall_thickness + sleeve_thickness, 0])
  rotate(-90, [0, 0, 1])
    extra_cards();

faction_counters();
general_counter(false);

color("green", 0.3) cube([box_width, box_height, box_depth]);
