use <../../shared/rounded_cube.scad>
use <../../shared/general_storage.scad>
use <../../shared/chit_storage.scad>

// objects

// cards
// counter

object = "counter";

inch = 25.4;
nozzle_diameter = 0.6;

box_outer_width = 223;
box_outer_height = 304;

box_wall_thickness = 2.5;

box_inner_width = box_outer_width - 2 * box_wall_thickness;
box_inner_height = box_outer_height - 2 * box_wall_thickness;
box_thickness = 30;

box_tolerance = 0;

sleeve_width = 60;
sleeve_height = 93;
sleeve_tolerance = 2;

wall_thickness = 2 * nozzle_diameter;

big_chit_size = 18.2;
small_chit_size = 15.2;
round_chit_diameter = 18.2;
hex_chit_size = 25;

rectangular_chit_short_side = 15.2;
rectangular_chit_long_side = 25.2;

chit_tolerance = 1;
chit_thickness = 1.5;

module card_side() {
  bottom_thickness = 1;

  render() difference() {
      cube(
        [
          (box_inner_width - box_tolerance) / 2,
          2 * (sleeve_width + sleeve_tolerance) + 3 * wall_thickness,
          box_thickness,
        ]
      );

      translate([wall_thickness, wall_thickness, bottom_thickness])
        cube([sleeve_height + sleeve_tolerance, sleeve_width + sleeve_tolerance, box_thickness - bottom_thickness]);

      translate([wall_thickness, 2 * wall_thickness + sleeve_width + sleeve_tolerance, bottom_thickness])
        cube([sleeve_height + sleeve_tolerance, sleeve_width + sleeve_tolerance, box_thickness - bottom_thickness]);

      translate([(box_inner_width - box_tolerance) / 2, wall_thickness + (sleeve_width + sleeve_tolerance) / 2, box_thickness])
        rotate(-90, [0, 1, 0])
          scale([1, 0.9, 1])
            cylinder(r=box_thickness - bottom_thickness, h=40, $fn=200);

      translate([(box_inner_width - box_tolerance) / 2, 2 * wall_thickness + 1.5 * (sleeve_width + sleeve_tolerance), box_thickness])
        rotate(-90, [0, 1, 0])
          scale([1, 0.9, 1])
            cylinder(r=box_thickness - bottom_thickness, h=40, $fn=200);
    }
}

if (is_undef(object) || object == "cards")
  card_side();

if (is_undef(object))
  translate([box_inner_width, 2 * (sleeve_width + sleeve_tolerance) + 3 * wall_thickness, 0])
    rotate(180, [0, 0, 1])
      card_side();

counter_offset = 2 * (sleeve_width + sleeve_tolerance) + 3 * wall_thickness + box_tolerance;

if (is_undef(object) || object == "counter") {
  translate([0, counter_offset, 0]) render() {
      available_height = box_inner_height - counter_offset;

      fill_storage_space(
        chit_size=big_chit_size,
        chit_tolerance=chit_tolerance,
        chit_thickness=chit_thickness,
        wall_thickness=wall_thickness,
        front_wall_thickness=wall_thickness,
        bottom_wall_thickness=1,
        fill_parameter=[
          [box_inner_width, 3],
          [available_height / 4, 1],
          [box_thickness, 2],
        ],
        single_for_printing=true
      );

      // translate([0, available_height / 4, 0])
      //   chit_storage(
      //     width=box_inner_width / 3,
      //     height=available_height / 4,
      //     depth=box_thickness / 2,
      //     wall_thickness=wall_thickness,
      //     front_wall_thickness=wall_thickness,
      //     columns=3,
      //     single_column=false,
      //     diameter=round_chit_diameter,
      //     chit_tolerance=chit_tolerance,
      //     chit_thickness=chit_thickness,
      //     chit_count_per_slot=5,
      //     render_cover_separate=false
      //   );

      // translate([0, available_height / 4, box_thickness / 2])
      //   chit_storage(
      //     chit_size=small_chit_size,
      //     chit_tolerance=chit_tolerance,
      //     chit_thickness=chit_thickness,
      //     wall_thickness=wall_thickness,
      //     front_wall_thickness=wall_thickness,
      //     width=box_inner_width / 3,
      //     height=available_height / 4,
      //     depth=box_thickness / 2,
      //     columns=3,
      //     single_column=false,
      //     chit_count_per_slot=9
      //   );

      // translate([0, available_height * 2 / 4, 0])
      //   fill_storage_space(
      //     chit_size=[rectangular_chit_long_side, rectangular_chit_short_side],
      //     chit_tolerance=chit_tolerance,
      //     chit_thickness=chit_thickness,
      //     wall_thickness=wall_thickness,
      //     front_wall_thickness=wall_thickness,
      //     bottom_wall_thickness=1,
      //     fill_parameter=[
      //       [box_inner_width, 6],
      //       [available_height / 4, 1],
      //       [box_thickness, 2],
      //     ],
      //     single_for_printing=true
      //   );

      // translate([0, available_height * 3 / 4, 0])
      //   chit_storage(
      //     diameter=hex_chit_size,
      //     rounded_ness=6,
      //     chit_tolerance=2 * chit_tolerance,
      //     chit_thickness=chit_thickness,
      //     wall_thickness=6,
      //     front_wall_thickness=wall_thickness,
      //     width=box_inner_width / 3,
      //     height=available_height / 4,
      //     depth=box_thickness / 2,
      //     chit_count_per_slot=9,
      //     columns=2,
      //   );
    }
}
