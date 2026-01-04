use <../../shared/chit_storage.scad>

inch = 25.4;

count = 2;

chit_size = 5 / 8 * inch;
chit_thickness = 2;
chit_tolerance = 1;

wall_thickness = 3;
bottom_wall_thickness = 2;

extent = chit_size + chit_tolerance + 2 * wall_thickness;
thickness = count * chit_thickness + bottom_wall_thickness;

chit_storage(
  width=extent,
  height=extent,
  depth=thickness,
  wall_thickness=wall_thickness,
  front_wall_thickness=wall_thickness,
  columns=1,
  single_column=true,
  chit_size=chit_size,
  chit_tolerance=chit_tolerance,
  chit_thickness=chit_thickness,
  chit_count_per_slot=count,
);
