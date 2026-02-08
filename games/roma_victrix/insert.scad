use <../../shared/general_storage.scad>
use <../../shared/chit_storage.scad>

// objects
// cards_big
// cards_small

// counter_tray
// filler_tray

nozzle_size = 0.6;
inch = 25.4;

og_box_height = 293;
og_box_width = 228;

og_box_wall_thickness = 2;

inner_box_width = og_box_width - 2 * og_box_wall_thickness;
inner_box_height = og_box_height - 2 * og_box_wall_thickness;
inner_box_depth = 44;

tolerance = 2;

sleeve_width = 66.5;
sleeve_height = 92.5;
sleeve_tolerance = 2;

event_cards = 21;
province_cards = 89;

chit_size = 9 / 16 * inch;
chit_tolerance = 2 * nozzle_size;
chit_thickness = 2.1;

wall_thickness = 2 * nozzle_size;

total_chit_count = 2292;

card_box_height = sleeve_height + 4 * wall_thickness + sleeve_tolerance;

if (is_undef(object) || object == "cards_big") {
  chit_storage(
    chit_size=[sleeve_width, sleeve_height],
    chit_tolerance=sleeve_tolerance,
    chit_thickness=1,
    wall_thickness=wall_thickness,
    front_wall_thickness=2 * wall_thickness,
    width=(inner_box_width - tolerance) / 3,
    height=card_box_height,
    depth=inner_box_depth,
    columns=1,
    chit_count_per_slot=42,
    front_wall_width=sleeve_width / 4,
  );
}

if (is_undef(object) || object == "cards_small") {
  translate([(inner_box_width - tolerance) / 3, 0, 0]) {
    chit_storage(
      chit_size=[sleeve_width, sleeve_height],
      chit_tolerance=sleeve_tolerance,
      chit_thickness=1,
      wall_thickness=wall_thickness,
      front_wall_thickness=2 * wall_thickness,
      width=(inner_box_width - tolerance) / 3,
      height=card_box_height,
      depth=inner_box_depth / 2,
      columns=1,
      chit_count_per_slot=20,
      front_wall_width=sleeve_width / 4,
    );

    if (is_undef(object)) {
      translate([0, 0, inner_box_depth / 2]) chit_storage(
          chit_size=[sleeve_width, sleeve_height],
          chit_tolerance=sleeve_tolerance,
          chit_thickness=1,
          wall_thickness=wall_thickness,
          front_wall_thickness=2 * wall_thickness,
          width=(inner_box_width - tolerance) / 3,
          height=card_box_height,
          depth=inner_box_depth / 2,
          columns=1,
          chit_count_per_slot=20,
          front_wall_width=sleeve_width / 4,
        );
    }
  }
}

if (is_undef(object) || object == "counter_tray") {
  translate([0, card_box_height + 2, 0])
    fill_storage_space(
      chit_size=chit_size,
      chit_tolerance=chit_tolerance,
      chit_thickness=chit_thickness,
      wall_thickness=wall_thickness,
      front_wall_thickness=wall_thickness,
      fill_parameter=[
        [inner_box_width - 2, 3],
        [inner_box_height - card_box_height - 2, 5],
        [inner_box_depth, 3],
      ],
      //   finger_space_width=8,
      single_for_printing=!is_undef(object) && object == "counter_tray"
    );
}

if (is_undef(object) || object == "filler_tray") {
  translate([3 * (inner_box_width - tolerance) / 3, 0, 0])
    rotate(90, [0, 0, 1])
      fill_storage_space(
        chit_size=chit_size,
        chit_tolerance=chit_tolerance,
        chit_thickness=chit_thickness,
        wall_thickness=wall_thickness,
        front_wall_thickness=wall_thickness,
        fill_parameter=[
          [card_box_height + 1, 1],
          [(inner_box_width - tolerance) / 3, 2],
          [inner_box_depth, 3],
        ],
        //   finger_space_width=8,
        single_for_printing=!is_undef(object) && object == "filler_tray"
      );
}

if (is_undef(object)) {
  color("green", 0.3) cube([inner_box_width, inner_box_height, inner_box_depth]);
}
