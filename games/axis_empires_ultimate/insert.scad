use <../../shared/vertical_card_box.scad>

// objects

// axis_cards_totaler_krieg

nozzle_size = 0.6;

og_box_height = 286;
og_box_width = 440;

og_box_wall_thickness = 3;

inner_box_width = og_box_width - 2 * og_box_wall_thickness;
inner_box_height = og_box_height - 2 * og_box_wall_thickness;
inner_box_depth = 71;

tolerance = 2;

// chit_size = 16.7;
// chit_tolerance = 2 * nozzle_size;
// chit_thickness = 2;

wall_thickness = 2 * nozzle_size;

sleeve_width = 66.5;
sleeve_height = 92.5;
sleeve_tolerance = 2;

card_box_width = sleeve_height + sleeve_tolerance + 4 * wall_thickness;
axis_cards_totaler_krieg_width = 70;

if (is_undef(object) || object == "axis_cards_totaler_krieg") {
  translate([card_box_width, 0, 0])
    rotate(90, [0, 0, 1])
      vertical_card_box(
        extents=[axis_cards_totaler_krieg_width, card_box_width, inner_box_depth],
        corner_radius=2, card_extents=[sleeve_width, sleeve_height],
        card_count=80
      );
}

if (is_undef(object) || object == "soviet_cards_totaler_krieg") {
  translate([card_box_width, axis_cards_totaler_krieg_width, 0])
    rotate(90, [0, 0, 1])
      vertical_card_box(
        extents=[70, card_box_width, inner_box_depth],
        corner_radius=2, card_extents=[sleeve_width, sleeve_height],
        card_count=80
      );
}

if (is_undef(object)) {
  color("green", 0.3) cube([inner_box_width, inner_box_height, inner_box_depth]);
}
