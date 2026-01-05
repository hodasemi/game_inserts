use <../../shared/general_storage.scad>

inch = 25.4;
nozzle_size = 0.6;

og_box_depth = 3 * inch;
og_box_height = 290;
og_box_width = 225;

chit_size = 5 / 8 * inch;
chit_tolerance = 1;
chit_thickness = 2;

fill_storage_space(
  chit_size=chit_size,
  chit_tolerance=chit_tolerance,
  chit_thickness=chit_thickness,
  wall_thickness=2 * nozzle_size,
  front_wall_thickness=2 * nozzle_size,
  bottom_wall_thickness=1,
  fill_parameter=[[og_box_width, 2], [og_box_height, 7], [og_box_depth / 2, 2]],
  finger_space_width=15,
);
