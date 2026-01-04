use <chit_storage.scad>

function calculate_chit_count(chit_thickness, bottom_wall_thickness, depth, cover_thickness) =
  floor((depth - bottom_wall_thickness - cover_thickness) / chit_thickness);

module general_storage(
  chit_size,
  chit_diameter,
  rounded_ness,
  chit_tolerance,
  chit_thickness,
  wall_thickness = 1.2,
  front_wall_thickness = 1,
  bottom_wall_thickness = 1,
  width,
  height,
  depth,
  finger_space_width,
  cover = false,
  cover_thickness = 1,
  cover_wall_thickness = 1,
  cover_text,
  cover_text_size = 5,
  render_cover_separate = false,
) {
  chit_x_size = !is_undef(chit_size) ? is_list(chit_size) ? chit_size[0] : chit_size : 0;
  chit_y_size = !is_undef(chit_size) ? is_list(chit_size) ? chit_size[1] : chit_size : 0;

  column_count =
    is_undef(chit_diameter) ?
      height > width ?
        floor(
          (
            height - (
              !is_undef(finger_space_width) ?
                2 * (finger_space_width + wall_thickness)
              : 0
            ) + wall_thickness
          ) / (chit_x_size + chit_tolerance + wall_thickness)
        )
      : floor(
        (
          width - (
            !is_undef(finger_space_width) ?
              2 * (finger_space_width + wall_thickness)
            : 0
          ) + wall_thickness
        ) / (chit_x_size + chit_tolerance + wall_thickness)
      )
    : floor(
      (
        width - (
          !is_undef(finger_space_width) ?
            2 * (finger_space_width + wall_thickness)
          : 0
        ) + wall_thickness
      ) / (chit_diameter + chit_tolerance + wall_thickness)
    );

  chit_count = calculate_chit_count(chit_thickness, bottom_wall_thickness, depth, cover ? cover_thickness : 0);

  echo(chit_count);

  chit_storage(
    width=width,
    height=height,
    depth=depth,
    wall_thickness=wall_thickness,
    front_wall_thickness=front_wall_thickness,
    chit_size=chit_size,
    diameter=chit_diameter,
    rounded_ness=rounded_ness,
    chit_tolerance=chit_tolerance,
    chit_thickness=chit_thickness,
    columns=column_count,
    chit_count_per_slot=chit_count,
    single_column=false,
    finger_spaces=!is_undef(finger_space_width),
    finger_space_width=!is_undef(finger_space_width) ? finger_space_width : 0,
    cover=cover,
    cover_thickness=cover_thickness,
    cover_wall_thickness=cover_wall_thickness,
    cover_text=cover_text,
    cover_text_size=cover_text_size,
    render_cover_separate=render_cover_separate,
  );
}

module storage_spacer(
  chit_size,
  chit_tolerance,
  chit_thickness,
  bottom_wall_thickness,
  width,
  height,
  depth,
) {
  chit_x_size = is_list(chit_size) ? chit_size[0] : chit_size;
  chit_count = calculate_chit_count(chit_thickness, bottom_wall_thickness, depth);

  for (i = [0:chit_count - 2]) {
    translate([(chit_x_size + chit_tolerance + chit_x_size / 2) * i, 0, 0])
      chit_storage_filler(
        text=chit_count - (i + 1),
        text_size=6,
        chit_size=chit_size,
        chit_tolerance=chit_tolerance,
        chit_thickness=chit_thickness,
        chit_count=i + 1
      );
  }
}

module fill_storage_space(
  chit_size,
  chit_diameter,
  rounded_ness,
  chit_tolerance,
  chit_thickness,
  wall_thickness = 1.2,
  front_wall_thickness = 1.2,
  bottom_wall_thickness = 1,
  fill_parameter = [[220, 2], [290, 7], [35, 3]],
  finger_space_width,
  cover = false,
  cover_thickness = 1,
  cover_wall_thickness = 1,
  single_for_printing = false,
) {
  box_width = fill_parameter[0][0];
  box_height = fill_parameter[1][0];
  box_thickness = fill_parameter[2][0];

  echo(box_width);
  echo(box_height);
  echo(box_thickness);

  storage_x_side_count = fill_parameter[0][1];
  storage_y_side_count = fill_parameter[1][1];
  storage_staple_count = fill_parameter[2][1];

  echo(storage_x_side_count);
  echo(storage_y_side_count);
  echo(storage_staple_count);

  storage_width = box_width / storage_x_side_count;
  storage_height = box_height / storage_y_side_count;
  storage_depth = box_thickness / storage_staple_count;

  if (single_for_printing) {
    general_storage(
      chit_size=chit_size,
      chit_diameter=chit_diameter,
      rounded_ness=rounded_ness,
      chit_thickness=chit_thickness,
      chit_tolerance=chit_tolerance,
      wall_thickness=wall_thickness,
      front_wall_thickness=front_wall_thickness,
      bottom_wall_thickness=bottom_wall_thickness,
      width=storage_width,
      height=storage_height,
      depth=storage_depth,
      finger_space_width=finger_space_width,
      cover=cover,
      cover_thickness=cover_thickness,
      cover_wall_thickness=cover_wall_thickness,
    );
  } else {
    for (x = [0:storage_x_side_count - 1]) {
      for (y = [0:storage_y_side_count - 1]) {
        for (z = [0:storage_staple_count - 1]) {
          translate([x * storage_width, y * storage_height, z * storage_depth])
            general_storage(
              chit_size=chit_size,
              chit_diameter=chit_diameter,
              rounded_ness=rounded_ness,
              chit_thickness=chit_thickness,
              chit_tolerance=chit_tolerance,
              wall_thickness=wall_thickness,
              front_wall_thickness=front_wall_thickness,
              bottom_wall_thickness=bottom_wall_thickness,
              width=storage_width,
              height=storage_height,
              depth=storage_depth,
              finger_space_width=finger_space_width,
              cover=cover,
              cover_thickness=cover_thickness,
              cover_wall_thickness=cover_wall_thickness,
            );
        }
      }
    }
  }
}

fill_storage_space(
  chit_size=15,
  chit_tolerance=1,
  chit_thickness=1.5,
  front_wall_thickness=1.5,
  wall_thickness=0.7,
  fill_parameter=[[213, 2], [295, 8], [8, 1]],
  cover=true,
);
