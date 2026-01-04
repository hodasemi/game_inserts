module rounded_cube(
  extents,
  corner_radius = 3,
) {
  $fn = 50;

  hull() {
    translate([corner_radius, corner_radius, 0])
      cylinder(h=extents[2], r=corner_radius);

    translate([extents[0] - corner_radius, corner_radius, 0])
      cylinder(h=extents[2], r=corner_radius);

    translate([corner_radius, extents[1] - corner_radius, 0])
      cylinder(h=extents[2], r=corner_radius);

    translate([extents[0] - corner_radius, extents[1] - corner_radius, 0])
      cylinder(h=extents[2], r=corner_radius);
  }
}
