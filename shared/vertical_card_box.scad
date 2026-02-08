use <rounded_cube.scad>

function card_extents(type) =
  type == "common_standard" ? [66.5, 92.5]
  : type == "american_standard" ? [60, 93]
  : type == "european_standard" ? [63, 96]
  : assert(false, "unknown card type");

module vertical_card_box_row(
  row_extents = [220, 100, 75],
  inter_box_tolerance = 1,
  corner_radius = 3,
  card_extents = card_extents("common_standard"),
  card_tolerance = 2,
  card_thickness = 0.7,
  card_counts = [20, 30, 50]
) {
  spaces = [for (count = card_counts) count * card_thickness];
  function space_until(index) = index == 0 ? 0 : spaces[index - 1] + space_until(index - 1);

  available_split_space = (row_extents[0] - (len(card_counts) - 1) * inter_box_tolerance - space_until(len(spaces))) / len(card_counts);

  for (i = [0:len(card_counts) - 1]) {
    translate([space_until(i) + i * available_split_space + i * inter_box_tolerance, 0, 0])
      vertical_card_box(
        extents=[available_split_space + spaces[i], row_extents[1], row_extents[2]],
        corner_radius=corner_radius,
        card_extents=card_extents,
        card_tolerance=card_tolerance,
        card_thickness=card_thickness,
        card_count=card_counts[i],
      );
  }
}

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
