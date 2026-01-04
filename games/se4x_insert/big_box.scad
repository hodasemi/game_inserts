use <base_empire.scad>
use <alternate_empire.scad>
use <replicator.scad>
use <../../shared/chit_storage.scad>
use <../../shared/chit_box.scad>

// objects

// card_tray_1
// card_tray_2
// hex_area

// card_tray_filler
// bottom_spacer
// hex_filler_1
// hex_filler_2
// inter_hex_filler
// top_spacer

// base_empire
// alternate_empire
// replicator

inter_part_tolerance = 1;
empire_chit_box_height = 127;
empire_box_depth = 20;
grid_size = 7;

// box
box_wall_thickness = 2.8;
box_width = 224 - 2 * box_wall_thickness;
box_height = 298 - 2 * box_wall_thickness;
box_depth = 100;

module box() {
  color("grey") {
    translate([0, 0, -box_wall_thickness])
      cube([box_width, box_height, box_wall_thickness]);

    translate([0, -box_wall_thickness, 0])
      cube([box_width, box_wall_thickness, box_depth]);

    translate([-box_wall_thickness, 0, 0])
      cube([box_wall_thickness, box_height, box_depth]);

    translate([0, box_height, 0])
      cube([box_width, box_wall_thickness, box_depth]);

    translate([box_width, 0, 0])
      cube([box_wall_thickness, box_height, box_depth]);
  }
}

// hex tiles
hex_tile_count = 220;
hex_tile_size = 55;
hex_tile_height = 2;
hex_tile_tolerance = 2;
hex_tile_r = (sqrt(3) / 2) * ( (hex_tile_size + hex_tile_tolerance) / 2);

hex_wall_thickness = 1.5;

module hex_chamber(count) {
  difference() {
    cylinder(
      r=(hex_tile_size + hex_tile_tolerance) / 2 + hex_wall_thickness,
      h=hex_tile_height * count + hex_wall_thickness,
      $fn=6
    );

    translate([0, 0, hex_wall_thickness])
      cylinder(
        r=(hex_tile_size + hex_tile_tolerance) / 2,
        h=hex_tile_height * count + 1,
        $fn=6
      );

    cylinder(r=hex_tile_size / 4, h=hex_tile_height, $fn=50);

    hull() {
      translate([0, 2 * hex_tile_r, hex_tile_height * count + hex_wall_thickness])
        rotate(90, [1, 0, 0])
          cylinder(r=hex_tile_r / 3, h=3 * hex_tile_r + 2 * hex_wall_thickness, $fn=30);

      translate([0, 2 * hex_tile_r, hex_tile_height * count + hex_wall_thickness - (hex_tile_height * count + hex_wall_thickness) * 0.75])
        rotate(90, [1, 0, 0])
          cylinder(r=hex_tile_r / 3, h=3 * hex_tile_r + 2 * hex_wall_thickness, $fn=30);
    }
  }
}

hex_tile_height_offset = 2 * hex_tile_r + hex_wall_thickness;
hex_tile_half_height_offset = hex_tile_height_offset / 2;

half_long_inner = (hex_tile_size + hex_tile_tolerance) / 2;
angled_wall_thickness = hex_wall_thickness / cos(30);
hex_tile_width_offset = 1.5 * half_long_inner + angled_wall_thickness / 2;

module hex_area(count) {
  // 10 chambers with 22 tiles each
  render() translate([hex_tile_size / 2 + hex_wall_thickness + inter_part_tolerance, hex_tile_r + hex_wall_thickness, 0]) {
      // #1
      hex_chamber(count);

      // #2
      translate([hex_tile_width_offset, hex_tile_half_height_offset, 0])
        hex_chamber(count);

      // #3
      translate([0, hex_tile_height_offset, 0])
        hex_chamber(count);

      // #4
      translate([2 * hex_tile_width_offset, 0, 0])
        hex_chamber(count);

      // #5
      translate([2 * hex_tile_width_offset, hex_tile_height_offset, 0])
        hex_chamber(count);

      // #6
      translate([3 * hex_tile_width_offset, hex_tile_half_height_offset, 0])
        hex_chamber(count);

      // #7
      translate([0, 2 * hex_tile_height_offset, 0])
        hex_chamber(count);

      // #8
      translate([2 * hex_tile_width_offset, 2 * hex_tile_height_offset, 0])
        hex_chamber(count);

      // #9
      translate([hex_tile_width_offset, hex_tile_height_offset + hex_tile_half_height_offset, 0])
        hex_chamber(count);

      // #10
      translate([3 * hex_tile_width_offset, hex_tile_height_offset + hex_tile_half_height_offset, 0])
        hex_chamber(count);
    }
}

// cards
card_height = 93;
card_width = 68;
card_thickness = 0.7;

card_wall_thickness = 2;

// left side
resource_card_count = 80;
scenario_cards = 44;
replicator_crew_card_count = 13;
replicator_empire_advance_card_count = 6;

card_left_side_height = card_wall_thickness + resource_card_count * card_thickness + card_wall_thickness + scenario_cards * card_thickness + card_wall_thickness + replicator_crew_card_count * card_thickness + card_wall_thickness + replicator_empire_advance_card_count * card_thickness + card_wall_thickness;

// right side
crew_card_count = 74;
alien_tech_cards = 44;
empire_advance_card_count = 36;

card_right_side_height = card_wall_thickness + crew_card_count * card_thickness + card_wall_thickness + alien_tech_cards * card_thickness + card_wall_thickness + empire_advance_card_count * card_thickness + card_wall_thickness;

module card_trays(filter) {
  text_size = 5;
  text_extrusion = 0.5;

  // left side
  if (len(search(0, filter)) > 0) {
    render() translate([0, box_height - max(card_left_side_height, card_right_side_height), 0]) {
        difference() {
          cube(
            [
              card_height + 2 * card_wall_thickness,
              max(card_left_side_height, card_right_side_height),
              card_width + card_wall_thickness,
            ]
          );

          offset_1 = card_wall_thickness;

          translate([card_wall_thickness, offset_1, card_wall_thickness])
            cube(
              [
                card_height,
                resource_card_count * card_thickness,
                card_width,
              ]
            );

          offset_2 = offset_1 + resource_card_count * card_thickness + card_wall_thickness;

          translate([card_wall_thickness, offset_2, card_wall_thickness])
            cube(
              [
                card_height,
                scenario_cards * card_thickness,
                card_width,
              ]
            );

          offset_3 = offset_2 + scenario_cards * card_thickness + card_wall_thickness;

          translate([card_wall_thickness, offset_3, card_wall_thickness])
            cube(
              [
                card_height,
                replicator_crew_card_count * card_thickness,
                card_width,
              ]
            );

          offset_4 = offset_3 + replicator_crew_card_count * card_thickness + card_wall_thickness;

          translate([card_wall_thickness, offset_4, card_wall_thickness])
            cube(
              [
                card_height,
                replicator_empire_advance_card_count * card_thickness,
                card_width,
              ]
            );

          translate(
            [
              card_height / 2 + card_wall_thickness,
              max(card_left_side_height, card_right_side_height),
              card_width + card_wall_thickness,
            ]
          )
            rotate(90, [1, 0, 0])
              cylinder(r=card_height / 3, h=max(card_left_side_height, card_right_side_height), $fn=100);

          resource_metrics = textmetrics("RESOURCE", size=text_size);

          // left
          translate(
            [
              text_extrusion,
              card_wall_thickness + resource_card_count * card_thickness / 2 - text_size / 2,
              (card_width + card_wall_thickness) / 2 - resource_metrics.size.x / 2,
            ]
          )
            rotate(-90, [0, 1, 0])
              linear_extrude(text_extrusion)
                text(text="RESOURCE", size=text_size);

          // right
          translate(
            [
              card_height + 2 * card_wall_thickness - text_extrusion,
              card_wall_thickness + resource_card_count * card_thickness / 2 - text_size / 2,
              (card_width + card_wall_thickness) / 2 + resource_metrics.size.x / 2,
            ]
          )
            rotate(90, [0, 1, 0])
              linear_extrude(text_extrusion)
                text(text="RESOURCE", size=text_size);

          scenario_metrics = textmetrics("SCENARIO", size=text_size);

          // left
          translate(
            [
              text_extrusion,
              2 * card_wall_thickness + resource_card_count * card_thickness + scenario_cards * card_thickness / 2 - text_size / 2,
              (card_width + card_wall_thickness) / 2 - scenario_metrics.size.x / 2,
            ]
          )
            rotate(-90, [0, 1, 0])
              linear_extrude(text_extrusion)
                text(text="SCENARIO", size=text_size);

          // right
          translate(
            [
              card_height + 2 * card_wall_thickness - text_extrusion,
              2 * card_wall_thickness + resource_card_count * card_thickness + scenario_cards * card_thickness / 2 - text_size / 2,
              (card_width + card_wall_thickness) / 2 + scenario_metrics.size.x / 2,
            ]
          )
            rotate(90, [0, 1, 0])
              linear_extrude(text_extrusion)
                text(text="SCENARIO", size=text_size);

          replicator_metrics = textmetrics("REPLICATOR", size=text_size);

          // left
          translate(
            [
              text_extrusion,
              2 * card_wall_thickness + resource_card_count * card_thickness + scenario_cards * card_thickness + 10 - text_size / 2,
              (card_width + card_wall_thickness) / 2 - replicator_metrics.size.x / 2,
            ]
          )
            rotate(-90, [0, 1, 0])
              linear_extrude(text_extrusion)
                text(text="REPLICATOR", size=text_size);

          // right
          translate(
            [
              card_height + 2 * card_wall_thickness - text_extrusion,
              2 * card_wall_thickness + resource_card_count * card_thickness + scenario_cards * card_thickness + 10 - text_size / 2,
              (card_width + card_wall_thickness) / 2 + replicator_metrics.size.x / 2,
            ]
          )
            rotate(90, [0, 1, 0])
              linear_extrude(text_extrusion)
                text(text="REPLICATOR", size=text_size);
        }
      }
  }

  // right side
  if (len(search(1, filter)) > 0) {
    render() translate([0, box_height - max(card_left_side_height, card_right_side_height), 0])
        translate([2 * card_wall_thickness + card_height + 1, 0, 0])
          difference() {
            cube(
              [
                card_height + 2 * card_wall_thickness,
                max(card_left_side_height, card_right_side_height),
                card_width + card_wall_thickness,
              ]
            );

            offset_1 = card_wall_thickness;

            translate([card_wall_thickness, offset_1, card_wall_thickness])
              cube(
                [
                  card_height,
                  crew_card_count * card_thickness,
                  card_width,
                ]
              );

            offset_2 = offset_1 + crew_card_count * card_thickness + card_wall_thickness;

            translate([card_wall_thickness, offset_2, card_wall_thickness])
              cube(
                [
                  card_height,
                  alien_tech_cards * card_thickness,
                  card_width,
                ]
              );

            offset_3 = offset_2 + alien_tech_cards * card_thickness + card_wall_thickness;

            translate([card_wall_thickness, offset_3, card_wall_thickness])
              cube(
                [
                  card_height,
                  empire_advance_card_count * card_thickness,
                  card_width,
                ]
              );

            translate(
              [
                card_height / 2 + card_wall_thickness,
                max(card_left_side_height, card_right_side_height),
                card_width + card_wall_thickness,
              ]
            )
              rotate(90, [1, 0, 0])
                cylinder(r=card_height / 3, h=max(card_left_side_height, card_right_side_height), $fn=100);

            resource_metrics = textmetrics("CREW", size=text_size);

            // left
            translate(
              [
                text_extrusion,
                card_wall_thickness + crew_card_count * card_thickness / 2 - text_size / 2,
                (card_width + card_wall_thickness) / 2 - resource_metrics.size.x / 2,
              ]
            )
              rotate(-90, [0, 1, 0])
                linear_extrude(text_extrusion)
                  text(text="CREW", size=text_size);

            // right
            translate(
              [
                card_height + 2 * card_wall_thickness - text_extrusion,
                card_wall_thickness + crew_card_count * card_thickness / 2 - text_size / 2,
                (card_width + card_wall_thickness) / 2 + resource_metrics.size.x / 2,
              ]
            )
              rotate(90, [0, 1, 0])
                linear_extrude(text_extrusion)
                  text(text="CREW", size=text_size);

            scenario_metrics = textmetrics("ALIEN TECH", size=text_size);

            // left
            translate(
              [
                text_extrusion,
                2 * card_wall_thickness + crew_card_count * card_thickness + alien_tech_cards * card_thickness / 2 - text_size / 2,
                (card_width + card_wall_thickness) / 2 - scenario_metrics.size.x / 2,
              ]
            )
              rotate(-90, [0, 1, 0])
                linear_extrude(text_extrusion)
                  text(text="ALIEN TECH", size=text_size);

            // right
            translate(
              [
                card_height + 2 * card_wall_thickness - text_extrusion,
                2 * card_wall_thickness + crew_card_count * card_thickness + alien_tech_cards * card_thickness / 2 - text_size / 2,
                (card_width + card_wall_thickness) / 2 + scenario_metrics.size.x / 2,
              ]
            )
              rotate(90, [0, 1, 0])
                linear_extrude(text_extrusion)
                  text(text="ALIEN TECH", size=text_size);

            replicator_metrics = textmetrics("EMPIRE ADVANCE", size=text_size);

            // left
            translate(
              [
                text_extrusion,
                3 * card_wall_thickness + crew_card_count * card_thickness + alien_tech_cards * card_thickness + empire_advance_card_count * card_thickness / 2 - text_size / 2,
                (card_width + card_wall_thickness) / 2 - replicator_metrics.size.x / 2,
              ]
            )
              rotate(-90, [0, 1, 0])
                linear_extrude(text_extrusion)
                  text(text="EMPIRE ADVANCE", size=text_size);

            // right
            translate(
              [
                card_height + 2 * card_wall_thickness - text_extrusion,
                3 * card_wall_thickness + crew_card_count * card_thickness + alien_tech_cards * card_thickness + empire_advance_card_count * card_thickness / 2 - text_size / 2,
                (card_width + card_wall_thickness) / 2 + replicator_metrics.size.x / 2,
              ]
            )
              rotate(90, [0, 1, 0])
                linear_extrude(text_extrusion)
                  text(text="EMPIRE ADVANCE", size=text_size);
          }
  }
}

// filler
hexes = 10;
tiles_per_hex = hex_tile_count / hexes;
card_hex_difference = (card_width + card_wall_thickness) - (hex_tile_height * tiles_per_hex + hex_wall_thickness);
filler_wall_thickness = 1.5;

module filler(count, filter) {
  card_tray_filler_height = (card_width + card_wall_thickness) / 4;

  module card_tray_filler() {
    w = box_width - 4 * card_wall_thickness - 2 * inter_part_tolerance - 2 * card_height;
    h = max(card_left_side_height, card_right_side_height);
    d = card_tray_filler_height;

    translate([w, 0, 0])
      rotate(90, [0, 0, 1])
        chit_storage(
          width=h,
          height=w,
          depth=d,
          columns=6,
          chit_count_per_slot=8
        );
  }

  card_filler_x_offset = 4 * card_wall_thickness + 2 * inter_part_tolerance + 2 * card_height;
  card_filler_y_offset = box_height - max(card_left_side_height, card_right_side_height);

  // card tray filler - first
  if (len(search(0, filter)) > 0) {
    translate([card_filler_x_offset, card_filler_y_offset, 0]) card_tray_filler();
  }

  // card tray filler - second
  if (len(search(1, filter)) > 0) {
    translate([card_filler_x_offset, card_filler_y_offset, card_tray_filler_height]) card_tray_filler();
  }

  // card tray filler - third
  if (len(search(2, filter)) > 0) {
    translate([card_filler_x_offset, card_filler_y_offset, 2 * card_tray_filler_height]) card_tray_filler();
  }

  // card tray filler - fourth
  if (len(search(3, filter)) > 0) {
    translate([card_filler_x_offset, card_filler_y_offset, 3 * card_tray_filler_height]) card_tray_filler();
  }

  // hex filler right
  hex_height = 3 * hex_tile_height_offset + hex_wall_thickness;
  right_box_width = 100;

  module footprint() {
    difference() {
      translate(
        [
          box_width - right_box_width,
          0,
          0,
        ]
      )
        square(
          [
            right_box_width,
            hex_height / 2 - inter_part_tolerance / 2,
          ]
        );

      translate([box_width / 2, 2 * hex_tile_r]) square([40, 50]);

      translate([hex_tile_size / 2 + hex_wall_thickness + inter_part_tolerance, hex_tile_r + hex_wall_thickness, 0]) {
        radius = (hex_tile_size + hex_tile_tolerance) / 2 + hex_wall_thickness + 2 * inter_part_tolerance;

        translate([2 * hex_tile_width_offset, 0, 0])
          circle(
            r=radius,
            $fn=6
          );

        translate([3 * hex_tile_width_offset, hex_tile_half_height_offset, 0])
          circle(
            r=radius,
            $fn=6
          );
      }
    }
  }

  module hex_right_filler() {
    difference() {
      linear_extrude(hex_wall_thickness + count * hex_tile_height) footprint();

      translate([0, 0, filler_wall_thickness])
        linear_extrude(hex_wall_thickness + count * hex_tile_height - filler_wall_thickness)
          offset(-filler_wall_thickness) footprint();
    }
  }

  module hex_right_top_filler() {
    translate([0, -inter_part_tolerance, 0])
      mirror([0, 1, 0])
        hex_right_filler();
  }

  module hex_right_bottom_filler() {
    hex_right_filler();
  }

  if (len(search(4, filter)) > 0) {
    translate(
      [
        0,
        hex_height + inter_part_tolerance,
        0,
      ]
    ) hex_right_top_filler();
  }

  if (len(search(5, filter)) > 0) {
    hex_right_bottom_filler();
  }

  bottom_spacer_thickness = card_hex_difference - empire_box_depth;
  offset = (hex_wall_thickness + count * hex_tile_height + bottom_spacer_thickness) / 2;
  inter_hex_box_height = box_height - (hex_height + max(card_left_side_height, card_right_side_height) + 2 * inter_part_tolerance);

  module inter_hex_boxes() {
    chit_storage(
      width=(box_width - inter_part_tolerance) / 2,
      height=inter_hex_box_height,
      depth=offset,
      wall_thickness=3,
      front_wall_thickness=1.5,
      chit_count_per_slot=12
    );
  }

  if (len(search(6, filter)) > 0) {
    translate(
      [
        0,
        hex_height + inter_part_tolerance,
        0,
      ]
    )
      inter_hex_boxes();
  }

  if (len(search(7, filter)) > 0) {
    translate(
      [
        (box_width - inter_part_tolerance) / 2 + inter_part_tolerance,
        hex_height + inter_part_tolerance,
        0,
      ]
    )
      inter_hex_boxes();
  }

  if (len(search(8, filter)) > 0) {
    translate(
      [
        0,
        hex_height + inter_part_tolerance,
        offset,
      ]
    )
      inter_hex_boxes();
  }

  if (len(search(9, filter)) > 0) {
    translate(
      [
        (box_width - inter_part_tolerance) / 2 + inter_part_tolerance,
        hex_height + inter_part_tolerance,
        offset,
      ]
    )
      inter_hex_boxes();
  }

  module top_filler() {
    chit_box(
      name="Top Filler",
      width=box_width,
      height=box_height - 2 * inter_part_tolerance - 2 * empire_chit_box_height,
      depth=empire_box_depth,
      wall_thickness=0.8,
      ideal_grid_size=grid_size,
      render=len(filter) == 1 ? [2] : [0, 1],
    );
  }

  if (len(search(10, filter)) > 0) {
    translate([0, 0, card_width + card_wall_thickness - (card_hex_difference - empire_box_depth)])
      top_filler();
  }

  module bottom_spacer() {
    corner_radius = 5;
    wall_thickness = 5;
    box_count = 6;

    width = box_width;
    height = box_height - max(card_left_side_height, card_right_side_height) - inter_hex_box_height - 2 * inter_part_tolerance;

    module bottom_left_corner() {
      translate([corner_radius, corner_radius, 0])
        cylinder(r=corner_radius, h=bottom_spacer_thickness);
    }

    module bottom_right_corner() {
      translate([width - corner_radius, corner_radius, 0])
        cylinder(r=corner_radius, h=bottom_spacer_thickness);
    }

    module top_left_corner() {
      translate([corner_radius, height - corner_radius, 0])
        cylinder(r=corner_radius, h=bottom_spacer_thickness);
    }

    module top_right_corner() {
      translate([width - corner_radius, height - corner_radius, 0])
        cylinder(r=corner_radius, h=bottom_spacer_thickness);
    }

    difference() {
      union() {
        hull() {
          bottom_left_corner();
          top_left_corner();
          top_right_corner();
          bottom_right_corner();
        }
      }

      box_width = (width - (box_count + 1) * wall_thickness) / box_count;
      box_height = (height - (box_count + 1) * wall_thickness) / box_count;

      for (x = [0:box_count - 1]) {
        for (y = [0:box_count - 1]) {
          translate([(wall_thickness + box_width) * x + wall_thickness, (wall_thickness + box_height) * y + wall_thickness, 0])
            cube([box_width, box_height, bottom_spacer_thickness]);
        }
      }
    }
  }

  if (len(search(11, filter)) > 0) {
    render() bottom_spacer();
  }
}

card_trays(
  is_undef(object) ? [
      0, // left card tray
      1, // right card tray
    ]
  : object == "card_tray_1" ? [0]
  : object == "card_tray_2" ? [1] : []
);

filler(
  tiles_per_hex,
  is_undef(object) ?
    [
      0, // card tray filler first
      1, // card tray filler second
      2, // card tray filler third
      3, // card tray filler fourth
      6, // inter hex box left bottom
      7, // inter hex box right bottom
      8, // inter hex box left top
      9, // inter hex box right top
      11, // bottom spacer
    ]
  : object == "card_tray_filler" ? [0]
  : object == "inter_hex_filler" ? [6]
  : object == "bottom_spacer" ? [11] : []
);

translate([0, 0, card_hex_difference - empire_box_depth]) {
  filler(
    tiles_per_hex,
    is_undef(object) ?
      [
        4, // hex right filler top
        5, // hex right filler bottom
        10, // inter empire top
      ]
    : object == "hex_filler_1" ? [4]
    : object == "hex_filler_2" ? [5]
    : object == "top_spacer" ? [10] : []
  );

  if (is_undef(object) || object == "hex_area")
    hex_area(tiles_per_hex);

  // base empires
  if (is_undef(object) || object == "base_empire")
    color("LightBlue")
      translate([0, 0, hex_tile_height * tiles_per_hex + hex_wall_thickness])
        base_empire_chit_box(
          width=(box_width - inter_part_tolerance) / 2,
          height=empire_chit_box_height,
          depth=empire_box_depth,
          ideal_grid_size=grid_size,
          split=!is_undef(object) ? object == "base_empire" : false
        );

  if (is_undef(object))
    color("Red")
      translate([(box_width + inter_part_tolerance) / 2, 0, hex_tile_height * tiles_per_hex + hex_wall_thickness])
        base_empire_chit_box(
          width=(box_width - inter_part_tolerance) / 2,
          height=empire_chit_box_height,
          depth=empire_box_depth,
          ideal_grid_size=grid_size,
          split=false
        );

  if (is_undef(object) || object == "replicator")
    color("DarkViolet")
      translate(
        [
          0,
          inter_part_tolerance + empire_chit_box_height,
          hex_tile_height * tiles_per_hex + hex_wall_thickness,
        ]
      )
        replicator_chit_box(
          width=box_height - empire_chit_box_height - max(
            card_left_side_height,
            card_right_side_height
          ) - 2 * inter_part_tolerance,
          height=box_width,
          depth=empire_box_depth,
          ideal_grid_size=8,
          wall_thickness=1.7,
          split=!is_undef(object) ? object == "replicator" : false,
        );
}

if (is_undef(object))
  color("Green")
    translate([0, box_height - empire_chit_box_height, card_width + card_wall_thickness])
      base_empire_chit_box(
        width=(box_width - inter_part_tolerance) / 2,
        height=empire_chit_box_height,
        depth=empire_box_depth,
        ideal_grid_size=grid_size,
        split=false
      );

if (is_undef(object))
  color("Yellow")
    translate([(box_width + inter_part_tolerance) / 2, box_height - empire_chit_box_height, card_width + card_wall_thickness])
      base_empire_chit_box(
        width=(box_width - inter_part_tolerance) / 2,
        height=empire_chit_box_height,
        depth=empire_box_depth,
        ideal_grid_size=grid_size,
        split=false
      );

// alternate empires
if (is_undef(object) || object == "alternate_empire")
  color("Orange")
    translate([0, box_height - 2 * empire_chit_box_height - inter_part_tolerance, card_width + card_wall_thickness])
      alternate_empire_chit_box(
        width=(box_width - inter_part_tolerance) / 2,
        height=empire_chit_box_height,
        depth=empire_box_depth,
        ideal_grid_size=grid_size,
        split=!is_undef(object) ? object == "alternate_empire" : false
      );

if (is_undef(object))
  color("DarkOliveGreen")
    translate([(box_width + inter_part_tolerance) / 2, box_height - 2 * empire_chit_box_height - inter_part_tolerance, card_width + card_wall_thickness])
      alternate_empire_chit_box(
        width=(box_width - inter_part_tolerance) / 2,
        height=empire_chit_box_height,
        depth=empire_box_depth,
        ideal_grid_size=grid_size,
        split=false
      );

// box();

// use <../shared/general_storage.scad>

// chit_size = 16;
// chit_tolerance = 0.8;
// chit_thickness = 2;

// translate([0, box_height - 2 * empire_chit_box_height - inter_part_tolerance, card_width + card_wall_thickness])
//   fill_storage_space(
//     chit_size=chit_size,
//     chit_tolerance=chit_tolerance,
//     chit_thickness=chit_thickness,
//     fill_parameter=[
//       [box_width, 2],
//       [2 * empire_chit_box_height, 7],
//       [box_depth - (card_width + card_wall_thickness), 2],
//     ],
//     finger_space_width=8
//   );
