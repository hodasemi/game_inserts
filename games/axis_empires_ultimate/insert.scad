use <../../shared/vertical_card_box.scad>

// objects

// first_row_cards

nozzle_size = 0.6;

og_box_height = 286;
og_box_width = 440;

og_box_wall_thickness = 3;

inner_box_width = og_box_width - 2 * og_box_wall_thickness;
inner_box_height = og_box_height - 2 * og_box_wall_thickness;
inner_box_depth = 71;

tolerance = 1;

// chit_size = 16.7;
// chit_tolerance = 2 * nozzle_size;
// chit_thickness = 2;

wall_thickness = 2 * nozzle_size;

sleeve_tolerance = 2;
sleeve_thickness = 0.66;

// card counts
fortunes_of_war_card_count = 34;

// totaler krieg
soviet_totaler_krieg_card_count = 83;
axis_totaler_krieg_card_count = 100;

card_box_width = card_extents("common_standard")[1] + sleeve_tolerance + 4 * wall_thickness;

if (is_undef(object) || object == "first_row_cards") {
  translate([card_box_width, 0, 0])
    rotate(90, [0, 0, 1])
      vertical_card_box_row(
        row_extents=[inner_box_height, card_box_width, inner_box_depth],
        inter_box_tolerance=1,
        corner_radius=3,
        card_extents=card_extents("common_standard"),
        card_tolerance=2,
        card_thickness=sleeve_thickness,
        card_counts=[
          fortunes_of_war_card_count,
          soviet_totaler_krieg_card_count,
          axis_totaler_krieg_card_count,
        ]
      );
}

if (is_undef(object)) {
  color("green", 0.3) cube([inner_box_width, inner_box_height, inner_box_depth]);
}
