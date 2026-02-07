use <rounded_cube.scad>

module generate_spacer(
  wall_thickness = 5,
  area_split = [2, 2],
  fill_parameter = [[220, 2], [290, 2], [35, 1]],
  single_for_printing = false,
) {
  spacer_width = fill_parameter[0][0] / fill_parameter[0][1];
  spacer_height = fill_parameter[1][0] / fill_parameter[1][1];
  spacer_thickness = fill_parameter[2][0] / fill_parameter[2][1];

  for (x = [0:fill_parameter[0][1] - 1]) {
    for (y = [0:fill_parameter[1][1] - 1]) {
      for (z = [0:fill_parameter[2][1] - 1]) {
        if (single_for_printing && x == 0 && y == 0 && z == 0 || !single_for_printing) {
          translate([x * spacer_width, y * spacer_height, z * spacer_thickness])
            render()
              difference() {
                rounded_cube([spacer_width, spacer_height, spacer_thickness], corner_radius=wall_thickness);

                hole_width = (spacer_width - (area_split[0] + 1) * wall_thickness) / area_split[0];
                hole_height = (spacer_height - (area_split[1] + 1) * wall_thickness) / area_split[1];

                for (hx = [0:area_split[0] - 1]) {
                  for (hy = [0:area_split[1] - 1]) {

                    translate(
                      [
                        wall_thickness + hx * (hole_width + wall_thickness),
                        wall_thickness + hy * (hole_height + wall_thickness),
                        0,
                      ]
                    )
                      rounded_cube([hole_width, hole_height, spacer_thickness], corner_radius=wall_thickness / 2);
                  }
                }
              }
        }
      }
    }
  }
}
