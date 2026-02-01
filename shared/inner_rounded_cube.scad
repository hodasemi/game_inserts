module inner_rounded_cube(extents = [30, 30, 30], inner_radius = 3, roundedness = 100, wall_thickness = 1) {

  render() difference() {
      cube(extents);

      hull() {
        offset = inner_radius + wall_thickness;

        translate([offset, offset, offset])
          sphere(r=inner_radius, $fn=roundedness);

        translate([extents[0] - offset, offset, offset])
          sphere(r=inner_radius, $fn=roundedness);

        translate([extents[0] - offset, extents[1] - offset, offset])
          sphere(r=inner_radius, $fn=roundedness);

        translate([offset, extents[1] - offset, offset])
          sphere(r=inner_radius, $fn=roundedness);

        translate([offset, offset, extents[2] + offset])
          sphere(r=inner_radius, $fn=roundedness);

        translate([extents[0] - offset, offset, extents[2] + offset])
          sphere(r=inner_radius, $fn=roundedness);

        translate([extents[0] - offset, extents[1] - offset, extents[2] + offset])
          sphere(r=inner_radius, $fn=roundedness);

        translate([offset, extents[1] - offset, extents[2] + offset])
          sphere(r=inner_radius, $fn=roundedness);
      }
    }
}
