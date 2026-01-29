module chit_storage(
  width = 100,
  height = 25,
  depth = 22,
  wall_thickness = 2,
  front_wall_thickness = 1,
  front_wall_width = 2,
  columns = 5,
  single_column = true,
  chit_size = 16,
  diameter,
  rounded_ness = 100,
  chit_tolerance = 1,
  chit_thickness = 2,
  chit_count_per_slot = 10,
  finger_spaces = false,
  finger_space_width = 10,
  cover = false,
  cover_thickness = 1,
  cover_wall_thickness = 1,
  cover_text,
  cover_text_size = 5,
  render_cover_separate = false,
) {
  // actual_width = height > width ? height : width;
  // actual_height = height > width ? width : height;

  // vertical = height > width;

  actual_width = width;
  actual_height = height;

  vertical = false;

  chit_x_size = !is_undef(chit_size) ? is_list(chit_size) ? chit_size[0] : chit_size : 0;
  chit_y_size = !is_undef(chit_size) ? is_list(chit_size) ? chit_size[1] : chit_size : 0;
  chit_total_x_size = chit_x_size + chit_tolerance;
  chit_total_y_size = chit_y_size + chit_tolerance;

  chit_total_diameter = is_undef(diameter) ? 0 : diameter + chit_tolerance;

  row_width =
    is_undef(diameter) ?
      chit_total_x_size * columns + wall_thickness * (columns - 1)
    : chit_total_diameter * columns + wall_thickness * (columns - 1);
  row_offset = (actual_width - row_width) / 2;

  module chit_row() {
    for (i = [0:1:(columns - 1)]) {
      translate(
        [
          is_undef(diameter) ?
            (chit_total_x_size + wall_thickness) * i
          : (chit_total_diameter + wall_thickness) * i,
          0,
          0,
        ]
      ) {
        if (is_undef(diameter)) {
          cube([chit_total_x_size, chit_total_y_size, chit_thickness * chit_count_per_slot + chit_tolerance / 2]);

          radius = (chit_total_x_size - 2 * front_wall_width) / 2;

          translate([chit_total_x_size / 2, -1, -depth])
            scale([1, 1.25, 1])
              cylinder(r=radius, h=2 * depth, $fn=100);
        } else {
          translate([chit_total_diameter / 2, chit_total_diameter / 2, 0])
            cylinder(r=chit_total_diameter / 2, h=chit_thickness * chit_count_per_slot + chit_tolerance / 2, $fn=rounded_ness);

          radius = (chit_total_diameter - 2 * front_wall_width) / 2;

          translate([chit_total_diameter / 2, -1, -depth])
            scale([1, 1.25, 1])
              cylinder(r=radius, h=2 * depth, $fn=100);
        }
      }
    }
  }

  module finger_cylinder() {
    finger_space_height = (actual_height - 8) / 2;

    scale([1, finger_space_height / finger_space_width, 1])
      cylinder(r=finger_space_width, h=depth, $fn=100);
  }

  module cover() {
    render()
      difference() {
        union() {
          translate([0, 0, depth - cover_thickness])
            cube([actual_width, actual_height, cover_thickness]);

          translate([0, 0, depth / 2])
            difference() {

              cube([actual_width, actual_height, depth / 2]);

              translate([cover_wall_thickness, cover_wall_thickness, 0])
                cube(
                  [
                    actual_width - 2 * cover_wall_thickness,
                    actual_height - 2 * cover_wall_thickness,
                    depth / 2,
                  ]
                );
            }
        }

        if (is_string(cover_text)) {
          metrics = textmetrics(cover_text, cover_text_size);
          text_width = metrics.size.x;
          text_height = metrics.ascent;

          text_inset = min(0.5, cover_thickness / 2);

          translate([actual_width / 2 - text_width / 2, actual_height / 2 - text_height / 2, depth - text_inset])
            linear_extrude(text_inset)
              text(cover_text, cover_text_size);
        }
      }
  }

  translate([0, vertical ? actual_width : 0, 0])
    rotate(vertical ? 270 : 0, [0, 0, 1]) {
      render() difference() {
          cube([actual_width, actual_height, depth - (cover ? cover_thickness : 0)]);

          translate([row_offset, front_wall_thickness, depth - (chit_thickness * chit_count_per_slot) - chit_tolerance / 2 - (cover ? cover_thickness : 0)]) chit_row();

          if (!single_column) {
            translate([row_width + row_offset, actual_height - front_wall_thickness, depth - (chit_thickness * chit_count_per_slot) - chit_tolerance / 2 - (cover ? cover_thickness : 0)])
              rotate(180, [0, 0, 1])
                chit_row();

            if (finger_spaces) {
              single_chit_cube_height =
                is_undef(diameter) ? front_wall_thickness + chit_total_x_size + wall_thickness
                : front_wall_thickness + chit_total_diameter + wall_thickness;
              remaining_space = actual_height - 2 * single_chit_cube_height;

              translate([0, single_chit_cube_height + remaining_space / 2, 0])
                finger_cylinder();

              translate([actual_width, single_chit_cube_height + remaining_space / 2, 0])
                finger_cylinder();
            }
          }

          if (cover) {
            translate([0, 0, depth / 3])
              difference() {
                cube([actual_width, actual_height, depth * 2 / 3]);

                cover_tolerance = 0.3;

                translate([cover_wall_thickness + cover_tolerance, cover_wall_thickness + cover_tolerance, 0])
                  cube(
                    [
                      actual_width - 2 * (cover_wall_thickness + cover_tolerance),
                      actual_height - 2 * (cover_wall_thickness + cover_tolerance),
                      depth * 2 / 3,
                    ]
                  );
              }
          }
        }

      if (cover) {
        if (render_cover_separate) {
          translate([0, 2 * actual_height + 10, depth / 4])
            rotate(180, [1, 0, 0])
              translate([0, 0, -depth * 3 / 4])
                cover();
        } else {
          cover();
        }
      }
    }
}

module chit_storage_filler(
  text,
  text_size = 5,
  text_inset = 1,
  chit_size = 16,
  chit_tolerance = 1,
  chit_thickness = 2,
  chit_count = 10,
) {
  filler_fit_tolerance = 0.3;

  chit_x_size = is_list(chit_size) ? chit_size[0] : chit_size;
  chit_y_size = is_list(chit_size) ? chit_size[1] : chit_size;
  chit_total_x_size = chit_x_size + chit_tolerance - filler_fit_tolerance;
  chit_total_y_size = chit_y_size + chit_tolerance - filler_fit_tolerance;

  render() difference() {
      cube([chit_total_x_size, chit_total_y_size, chit_thickness * chit_count]);

      radius = (chit_total_x_size - 4) / 2;

      translate([chit_total_x_size / 2, -1, 0])
        scale([1, 1.25, 1])
          cylinder(r=radius, h=chit_thickness * chit_count, $fn=100);

      if (!is_undef(text)) {
        name = is_string(text) ? text : str(text);

        metrics = textmetrics(text=name, size=text_size);
        text_width = metrics.advance.x;
        text_height = metrics.ascent;

        translate([chit_total_x_size / 2 - text_width / 2, chit_total_y_size / 2, chit_thickness * chit_count - text_inset])
          linear_extrude(text_inset)
            text(name, text_size);
      }
    }
}

chit_storage(
  height=41,
  columns=4,
  front_wall_thickness=2,
  single_column=false,
  finger_spaces=true,
  cover=true,
  render_cover_separate=true,
  cover_text="Test",
);
