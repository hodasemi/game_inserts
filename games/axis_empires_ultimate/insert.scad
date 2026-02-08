use <../../shared/vertical_card_box.scad>
use <../../shared/general_storage.scad>
use <../../shared/spacer.scad>

// objects

// first_row_cards
// second_row_cards

// counter_tray

// spacer

spacer = 25.4;
nozzle_size = 0.6;

og_box_height = 286;
og_box_width = 440;

og_box_wall_thickness = 3;

inner_box_width = og_box_width - 2 * og_box_wall_thickness;
inner_box_height = og_box_height - 2 * og_box_wall_thickness;
inner_box_depth = 71;
blocker_depth = 30;
blocker_tolerance = 2;

tolerance = 1;

chit_size = 1 / 2 * spacer;
chit_tolerance = 2 * nozzle_size;
chit_thickness = 2.05;

chit_count = 2380;

wall_thickness = 2 * nozzle_size;

sleeve_tolerance = 2;
sleeve_thickness = 0.66;

// card counts
fortunes_of_war_card_count = 34;

// totaler krieg
soviet_totaler_krieg_card_count = 83;
axis_totaler_krieg_card_count = 100;
allies_totaler_krieg_card_count = 74;

// dai senso
soviet_dai_senso_card_count = 54;
axis_dai_senso_card_count = 74;
western_dai_senso_card_count = 81;

// card_box_width = card_extents("common_standard")[1] + sleeve_tolerance + 4 * wall_thickness;
card_box_width = (inner_box_width / 2 - blocker_tolerance) / 2 - 1;

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
          allies_totaler_krieg_card_count,
          soviet_dai_senso_card_count,
        ]
      );
}

if (is_undef(object) || object == "second_row_cards") {
  translate([2 * card_box_width + 1, 0, 0])
    rotate(90, [0, 0, 1])
      vertical_card_box_row(
        row_extents=[inner_box_height / 2, card_box_width, inner_box_depth],
        inter_box_tolerance=1,
        corner_radius=3,
        card_extents=card_extents("common_standard"),
        card_tolerance=2,
        card_thickness=sleeve_thickness,
        card_counts=[
          axis_dai_senso_card_count,
          western_dai_senso_card_count,
        ]
      );
}

if (is_undef(object) || object == "counter_tray") {
  translate([inner_box_width / 2, 0, blocker_depth])
    fill_storage_space(
      chit_size=chit_size,
      chit_tolerance=chit_tolerance,
      chit_thickness=chit_thickness,
      wall_thickness=wall_thickness,
      front_wall_thickness=wall_thickness,
      fill_parameter=[
        [inner_box_width / 2, 2],
        [inner_box_height - 2, 8],
        [inner_box_depth - blocker_depth, 3],
      ],
      finger_space_width=8,
      single_for_printing=!is_undef(object) && object == "counter_tray"
    );
}

if (is_undef(object) || object == "spacer") {
  translate([card_box_width + 1, inner_box_height / 2 + 1, 0])
    generate_spacer(
      wall_thickness=5,
      area_split=[2, 2],
      fill_parameter=[[card_box_width, 1], [inner_box_height / 2 - 1, 1], [inner_box_depth, 2]],
      single_for_printing=!is_undef(object) && object == "spacer"
    );
}

if (is_undef(object)) {
  color("black") translate([inner_box_width / 2 - blocker_tolerance, 0, 0]) cube([inner_box_width / 2 + blocker_tolerance, inner_box_height, blocker_depth]);
  color("green", 0.3) cube([inner_box_width, inner_box_height, inner_box_depth]);
}
