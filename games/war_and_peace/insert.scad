use <../../shared/general_storage.scad>
use <../../shared/rounded_cube.scad>
use <../../shared/spacer.scad>

// objects

// storage
// card_box
// filler
// spacer

object = "spacer";

box_outer_width = 294;
box_outer_height = 294;
box_outer_depth = 100;

box_wall_thickness = 2.3;

box_inner_width = box_outer_width - 2 * box_wall_thickness;
box_inner_height = box_outer_height - 2 * box_wall_thickness;
box_inner_depth = 101;

storage_tolerance = 1;

sleeve_width = 66.5;
sleeve_height = 92.5;
sleeve_tolerance = 2;
sleeve_thickness = 0.72;
sleeve_count = 54;

paper_width = 210;
paper_height = 280;
paper_thickness = 12;

map_thickness = 15.4;

wall_thickness = 2;

inner_width = sleeve_width + sleeve_tolerance;
inner_height = sleeve_height + sleeve_tolerance;
outer_width = box_inner_width - paper_width;
outer_height = 4 * wall_thickness + inner_height;

area_thickness = box_inner_depth - 2 * map_thickness - paper_thickness;

module card_box() {
  total_depth = box_inner_depth - 2 * map_thickness;
  thickness = sleeve_thickness * sleeve_count;

  render() difference() {
      rounded_cube(
        [
          outer_width,
          outer_height,
          total_depth,
        ],
        corner_radius=10
      );

      translate([(outer_width - thickness) / 2, 2 * wall_thickness, total_depth - inner_width])
        cube([thickness, inner_height, inner_width]);

      translate([0, (2 * wall_thickness + inner_height) / 2, total_depth])
        rotate(90, [0, 1, 0])
          cylinder(h=outer_height, r=inner_height / 4, $fn=100);
    }
}

module filler() {
  wall_thickness = 5;
  corner_radius = 10;

  w = box_inner_width - paper_width;
  h = box_inner_height - outer_height - storage_tolerance;
  d = box_inner_depth - 2 * map_thickness;

  render() difference() {
      rounded_cube(
        [
          w,
          h,
          d,
        ],
        corner_radius=corner_radius
      );

      translate([wall_thickness, wall_thickness, 0])
        rounded_cube(
          [
            w - 2 * wall_thickness,
            h / 2 - 1.5 * wall_thickness,
            d,
          ], corner_radius=corner_radius / 2
        );

      translate([wall_thickness, (wall_thickness + h) / 2, 0])
        rounded_cube(
          [
            w - 2 * wall_thickness,
            h / 2 - 1.5 * wall_thickness,
            d,
          ], corner_radius=corner_radius / 2
        );
    }
}

// color("white") translate([0, 0, box_inner_depth - 2 * map_thickness - paper_thickness]) cube([paper_width, paper_height, paper_thickness]);
// color("green") translate([0, 0, box_inner_depth - map_thickness]) cube([box_inner_width, box_inner_height, map_thickness]);
// color("brown") translate([0, 0, box_inner_depth - 2 * map_thickness]) cube([box_inner_width, box_inner_height, map_thickness]);
// color("lightblue", 0.5) cube([box_inner_width, box_inner_height, box_inner_depth]);

if (is_undef(object) || object == "card_box") {
  translate([paper_width, 0, 0])
    card_box();
}

if (is_undef(object) || object == "filler") {
  translate([paper_width, outer_height, 0])
    filler();
}

if (is_undef(object) || object == "spacer") {
  generate_spacer(
    wall_thickness=5,
    area_split=[2, 2],
    fill_parameter=[
      [paper_width - storage_tolerance, 2],
      [box_inner_height - storage_tolerance, 2],
      [area_thickness / 2, 1],
    ],
    single_for_printing=is_undef(object) || object != "spacer" ? false : true
  );
}

inch = 25.4;

chit_size = inch * 9 / 16;
chit_tolerance = 1;
chit_thickness = 2.1;

if (is_undef(object) || object == "storage") {
  translate([0, 0, area_thickness / 2])
    fill_storage_space(
      chit_size=chit_size,
      chit_tolerance=chit_tolerance,
      chit_thickness=chit_thickness,
      wall_thickness=1.2,
      front_wall_thickness=1.2,
      bottom_wall_thickness=1,
      fill_parameter=[
        [paper_width - storage_tolerance, 2],
        [box_inner_height - storage_tolerance, 8],
        [area_thickness / 2, 2],
      ],
      finger_space_width=10,
      cover=false,
      cover_thickness=1,
      cover_wall_thickness=1,
      single_for_printing=is_undef(object) || object != "storage" ? false : true
    );
}
