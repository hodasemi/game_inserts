use <rounded_cube.scad>

module vertical_card_box(
  extents = [50, 100, 75],
  corner_radius = 3,
  card_extents = [66.5, 92.5],
  card_tolerance = 2,
  card_thickness = 0.7,
  card_count = 55,
) {
  render() difference() {
      rounded_cube(extents=extents, corner_radius=corner_radius);

      cards_depth = card_extents[0] + card_tolerance;
      cards_height = card_extents[1] + card_tolerance;
      cards_thickness = card_thickness * card_count;

      translate([(extents[0] - cards_thickness) / 2, (extents[1] - cards_height) / 2, extents[2] - cards_depth])
        cube([cards_thickness, cards_height, cards_depth]);

      translate([0, extents[1] / 2, extents[2]])
        rotate(90, [0, 1, 0])
          cylinder(h=extents[0], r=extents[1] / 4, $fn=100);
    }
}
