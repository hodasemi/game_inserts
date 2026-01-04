use <../../shared/general_storage.scad>
use <../../shared/cup.scad>

// objects

// snafu
// objectives
// hasty_meeting
// prepared_deliberate

// storage
// filler
// spacer

total_box_height = 54;

og_box_depth = 33;
og_box_height = 290;
og_box_width = 225;

box_x_tolerance = 1;
box_y_tolerance = 2;

box_depth = og_box_depth;
box_height = og_box_height - box_y_tolerance;
box_width = og_box_width - box_x_tolerance;

inch = 25.4;

chit_size = inch * 9 / 16;
chit_thickness = 1.95;
chit_tolerance = 1;

cup_size = box_width / 2;
cup_thickness = box_depth / 2;

storage_staple_count = 3;
storage_y_side_count = 5;
storage_x_side_count = 2;

finger_space_width = 12;

storage_width = box_width / storage_x_side_count;
storage_height = (box_height - cup_size) / storage_y_side_count;
storage_depth = box_depth / storage_staple_count;

spacer_height = 9;
spacer_thickness = total_box_height - box_depth;

module spacer() {
  wall_thickness = 1;
  wall_twice = 2 * wall_thickness;

  translate([0, 0, box_depth])
    render() difference() {
        cube([box_width, spacer_height, spacer_thickness]);

        hole_width = (box_width - wall_twice) / 4;

        translate([wall_thickness, wall_thickness, 0])
          cube([hole_width, spacer_height - wall_twice, spacer_thickness - wall_thickness]);

        translate([3 / 8 * box_width + wall_thickness, wall_thickness, 0])
          cube([hole_width, spacer_height - wall_twice, spacer_thickness - wall_thickness]);

        translate([box_width - (wall_thickness + hole_width), wall_thickness, 0])
          cube([hole_width, spacer_height - wall_twice, spacer_thickness - wall_thickness]);

        translate([hole_width + hole_width / 4 + wall_thickness, spacer_thickness, spacer_thickness])
          rotate(90, [1, 0, 0])
            cylinder(h=spacer_thickness, r=spacer_height, $fn=50);

        translate([box_width - (hole_width + hole_width / 4 + wall_thickness), spacer_thickness, spacer_thickness])
          rotate(90, [1, 0, 0])
            cylinder(h=spacer_thickness, r=spacer_height, $fn=50);
      }
}

translate([0, box_height - cup_size, 0]) {
  if (is_undef(object) || object == "snafu")
    color("grey")
      cup("SNAFU", cup_size, cup_thickness, floor(cup_thickness / 2));

  if (is_undef(object) || object == "objectives")
    translate([0, 0, cup_thickness])
      color("purple")
        cup("OBJECTIVES", cup_size, cup_thickness, floor(cup_thickness / 2));

  if (is_undef(object) || object == "hasty_meeting")
    translate([cup_size, 0, 0])
      color("white")
        cup(["HASTY", "MEETING"], cup_size, cup_thickness, floor(cup_thickness / 2));

  if (is_undef(object) || object == "prepared_deliberate")
    translate([cup_size, 0, cup_thickness])
      color("blue")
        cup(["PREPARED", "DELIBERATE"], cup_size, cup_thickness, floor(cup_thickness / 2));
}

if (is_undef(object)) {
  for (x = [0:storage_x_side_count - 1]) {
    for (y = [0:storage_y_side_count - 1]) {
      for (z = [0:storage_staple_count - 1]) {
        translate([x * storage_width, y * storage_height, z * storage_depth])
          general_storage(
            chit_size,
            chit_tolerance,
            chit_thickness,
            width=storage_width,
            height=storage_height,
            depth=storage_depth,
            optimize_count=true,
            finger_space_width=finger_space_width,
          );
      }
    }
  }
} else if (object == "storage") {
  general_storage(
    chit_size,
    chit_tolerance,
    chit_thickness,
    width=storage_width,
    height=storage_height,
    depth=storage_depth,
    optimize_count=true,
    finger_space_width=finger_space_width,
  );
}

// if (is_undef(object) || object == "filler")
//   translate([0, -20, 0])
//     storage_spacer(
//       chit_size,
//       chit_tolerance,
//       chit_thickness,
//       width=storage_width,
//       height=storage_height,
//       depth=storage_depth,
//       optimize_count=true
//     );

if (is_undef(object) || object == "spacer")
  color("grey") spacer();
