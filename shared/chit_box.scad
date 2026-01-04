function add_sum_of_preceding(list, index) = index == 0 ? list[index] + 1 : list[index] + 1 + add_sum_of_preceding(list, index - 1);
function generate_offsets(list) = [for (i = [0:len(list)]) i == 0 ? 0 : add_sum_of_preceding(list, i - 1)];

function create_column(col, offsets, names) = [for (i = [0:len(names) - 1]) [col, offsets[i], names[i]]];

module chit_box(
  name,
  width = 100,
  height = 30,
  depth = 25,
  wall_thickness = 1.2,
  ideal_grid_size = 3,
  chit_size = 16,
  chit_tolerance = 1,
  chit_thickness = 2,
  text_size = 3.8,
  text_depth = 0.5,
  render = [0, 1],
  info = []
) {
  chit_rotation = -15;
  actual_chit_size = chit_size + chit_tolerance;
  required_chit_space = actual_chit_size / cos(chit_rotation);
  top_bottom_thickness = (depth - required_chit_space) / 2;

  module chit(info) {
    rotate(chit_rotation, [1, 0, 0]) if (is_string(info)) {
      difference() {
        cube([actual_chit_size, chit_thickness, actual_chit_size * 3 / 4]);

        metrics = textmetrics(info, size=text_size);
        text_width = metrics.size.x;

        translate([(actual_chit_size - text_width) / 2 - 0.3, text_depth, actual_chit_size / 4])
          rotate(90, [1, 0, 0])
            linear_extrude(text_depth)
              text(info, size=text_size);
      }
    } else {
      cube([actual_chit_size, chit_thickness, actual_chit_size]);
    }
  }

  module chit_position(x, y, info) {
    translate(
      [
        x * actual_chit_size + x * wall_thickness,
        y * ( (chit_thickness / cos(chit_rotation)) - 0.001),
        0,
      ]
    )
      chit(info);
  }

  module bottom() {
    if (is_string(name)) {
      echo("===== values for", name, "=====");
    }

    usable_width = width - 4 * wall_thickness;
    column_count = floor((usable_width - wall_thickness) / (actual_chit_size + wall_thickness));
    used_width = actual_chit_size * column_count + wall_thickness * (column_count - 1);
    column_offset = (usable_width - used_width) / 2;

    usable_height = height - 4 * wall_thickness;
    chits_per_row = floor((usable_height - (sin(abs(chit_rotation)) * actual_chit_size)) / (chit_thickness / cos(chit_rotation)));

    echo(usable_width=usable_width);
    echo(used_width=used_width);
    echo(columns=column_count);
    echo(chits_per_row=chits_per_row);
    echo(total_chit_count=chits_per_row * column_count);

    union() {
      difference() {
        cube([width, height, top_bottom_thickness + required_chit_space / 2]);

        translate([0, 0, top_bottom_thickness]) difference() {
            cube([width, height, required_chit_space / 2]);
            translate([wall_thickness, wall_thickness, 0]) cube([width - 2 * wall_thickness, height - 2 * wall_thickness, required_chit_space / 2]);
          }

        translate([column_offset + 2 * wall_thickness, 2 * wall_thickness, top_bottom_thickness]) {
          for (x = [0:1:column_count - 1]) {
            for (y = [0:1:chits_per_row - 1]) {
              chit_position(x, y);
            }
          }
        }
      }

      if (is_list(info)) {
        translate([column_offset + 2 * wall_thickness, 2 * wall_thickness, top_bottom_thickness]) {
          for (chit_info = info) {
            column = chit_info[0];
            pos_info = chit_info[1];

            assert(pos_info >= 0, "invalid info position in column");

            position = chits_per_row - 1 - pos_info;
            name = chit_info[2];

            chit_position(column, position, name);
          }
        }
      }
    }
  }

  module top() {
    union() {
      difference() {
        translate([0, 0, required_chit_space / 4])
          cube([width, height, top_bottom_thickness + required_chit_space * 3 / 4]);

        translate([wall_thickness, wall_thickness, 0])
          cube([width - 2 * wall_thickness, height - 2 * wall_thickness, required_chit_space / 2]);

        translate([2 * wall_thickness, 2 * wall_thickness, required_chit_space / 2])
          cube([width - 4 * wall_thickness, height - 4 * wall_thickness, top_bottom_thickness + required_chit_space / 2]);
      }

      grid_width = width - 4 * wall_thickness;
      tmp_x = ceil((grid_width / ideal_grid_size) / ideal_grid_size) * ideal_grid_size;
      actual_count_x = (tmp_x % 2 == 0) ? tmp_x + 1 : tmp_x;
      actual_size_x = grid_width / actual_count_x;

      grid_height = height - 4 * wall_thickness;
      tmp_y = ceil((grid_height / ideal_grid_size) / ideal_grid_size) * ideal_grid_size;
      actual_count_y = (tmp_y % 2 == 0) ? tmp_y + 1 : tmp_y;
      actual_size_y = grid_height / actual_count_y;

      translate([2 * wall_thickness, 2 * wall_thickness, required_chit_space]) difference() {
          cube([grid_width, grid_height, top_bottom_thickness]);

          for (x = [0:2:actual_count_x]) {
            for (y = [0:2:actual_count_y]) {
              translate([actual_size_x * x, actual_size_y * y, 0])
                cube([actual_size_x, actual_size_y, top_bottom_thickness]);
            }
          }
        }
    }
  }

  render() {
    if (len(search(2, render)) > 0) {
      color("red") bottom();

      translate([width, height + 20, top_bottom_thickness + required_chit_space])
        rotate(180, [0, 1, 0])
          color("green") top();
    } else {
      if (len(search(0, render)) > 0) {
        bottom();
      }

      if (len(search(1, render)) > 0) {
        translate([0, 0, top_bottom_thickness])
          top();
      }
    }
  }
}

chit_box(
  name="test",
  width=200,
  height=50,
  depth=25,
  render=[0, 1, 2],
  info=[[0, 0, "bla"], [1, 0, "blub"], [0, 1], [2, 0]]
);
