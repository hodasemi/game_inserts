use <../../shared/vertical_card_box.scad>

// objects

// fortunes_of_war_cards
// soviet_cards_totaler_krieg
// soviet_cards_totaler_krieg

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

sleeve_width = 66.5;
sleeve_height = 92.5;
sleeve_tolerance = 2;
sleeve_thickness = 0.66;

// card counts
fortunes_of_war_card_count = 34;

// totaler krieg
soviet_totaler_krieg_card_count = 83;
axis_totaler_krieg_card_count = 100;

card_box_width = sleeve_height + sleeve_tolerance + 4 * wall_thickness;

function card_box_height(count) = count * sleeve_thickness + 8 * wall_thickness;

axis_cards_totaler_krieg_width = card_box_height(axis_totaler_krieg_card_count);
soviet_cards_totaler_krieg_width = card_box_height(soviet_totaler_krieg_card_count);
fortunes_of_war_cards_width = card_box_height(fortunes_of_war_card_count);

if (is_undef(object) || object == "axis_cards_totaler_krieg") {
  translate([card_box_width, 0, 0])
    rotate(90, [0, 0, 1])
      vertical_card_box(
        extents=[axis_cards_totaler_krieg_width, card_box_width, inner_box_depth],
        corner_radius=2, card_extents=[sleeve_width, sleeve_height],
        card_count=axis_totaler_krieg_card_count,
        card_thickness=sleeve_thickness,
      );
}

if (is_undef(object) || object == "soviet_cards_totaler_krieg") {
  translate([card_box_width, axis_cards_totaler_krieg_width + tolerance, 0])
    rotate(90, [0, 0, 1])
      vertical_card_box(
        extents=[soviet_cards_totaler_krieg_width, card_box_width, inner_box_depth],
        corner_radius=2, card_extents=[sleeve_width, sleeve_height],
        card_count=soviet_totaler_krieg_card_count,
        card_thickness=sleeve_thickness,
      );
}

if (is_undef(object) || object == "fortunes_of_war_cards") {
  translate([card_box_width, soviet_cards_totaler_krieg_width + axis_cards_totaler_krieg_width + 2 * tolerance, 0])
    rotate(90, [0, 0, 1])
      vertical_card_box(
        extents=[fortunes_of_war_cards_width, card_box_width, inner_box_depth],
        corner_radius=2, card_extents=[sleeve_width, sleeve_height],
        card_count=fortunes_of_war_card_count,
        card_thickness=sleeve_thickness,
      );
}

if (is_undef(object)) {
  color("green", 0.3) cube([inner_box_width, inner_box_height, inner_box_depth]);
}
