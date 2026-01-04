use <../../shared/general_storage.scad>
use <../../shared/rounded_cube.scad>

// objects

// counter_storage
// spacer
// filler

// object = "filler";

depth = 37;
width = 220;
height = 297;

inch = 25.4;

chit_size = inch * 9 / 16;
chit_tolerance = 1;
chit_thickness = 1.65;

spacer_width = width / 2;
spacer_height = height / 2;
spacer_thickness = 22;

if (is_undef(object) || object == "counter_storage") {
  translate([0, 0, spacer_thickness])
    fill_storage_space(
      chit_size=chit_size,
      chit_tolerance=chit_tolerance,
      chit_thickness=chit_thickness,
      wall_thickness=1.3,
      front_wall_thickness=1.3,
      bottom_wall_thickness=1,
      fill_parameter=[[width, 2], [height, 8], [depth - spacer_thickness, 1]],
      finger_space_width=10,
      single_for_printing=is_undef(object) || object != "counter_storage" ? false : true
    );
}

module spacer() {
  wall_thickness = 5;
  holes = 2;

  render() difference() {
      rounded_cube([spacer_width, spacer_height, spacer_thickness], corner_radius=wall_thickness);

      hole_width = (spacer_width - (holes + 1) * wall_thickness) / holes;
      hole_height = (spacer_height - (holes + 1) * wall_thickness) / holes;

      for (x = [0:holes - 1]) {
        for (y = [0:holes - 1]) {

          translate(
            [
              wall_thickness + x * (hole_width + wall_thickness),
              wall_thickness + y * (hole_height + wall_thickness),
              0,
            ]
          )
            rounded_cube([hole_width, hole_height, spacer_thickness], corner_radius=wall_thickness / 2);
        }
      }
    }
}

module filler() {
  w = width - 1;
  height = 15;
  thickness = 13.5;

  render() difference() {
      cube([w, height, thickness]);

      translate([w / 2, -1.25 * height, 0])
        // rotate(-90, [1, 0, 0])
        cylinder(r=2 * height, h=height, $fn=100);
    }
}

if (is_undef(object) || object == "filler") {
  translate([0, 0, is_undef(object) ? depth : 0])
    filler();
}

if (is_undef(object) || object == "spacer") {
  spacer();
}

if (is_undef(object)) {
  translate([spacer_width, 0, 0]) spacer();
  translate([0, spacer_height, 0]) spacer();
  translate([spacer_width, spacer_height, 0]) spacer();
}
