use <../../shared/general_storage.scad>

chit_size = 15;
chit_tolerance = 1;
chit_thickness = 1.5;

wall_thickness = 1.2;
cover_wall_thickness = 0.8;
front_wall_thickness = 2.2;

width = 6 * wall_thickness + 5 * (chit_size + chit_tolerance) + 2 * (cover_wall_thickness + 0.3);
height = 2 * (chit_size + chit_tolerance) + 3 * wall_thickness + 2 * (cover_wall_thickness + 0.3);
depth = 8;

finger_space_width = 10;

cover_text = "SADOWA";
// cover_text = "SADOWA - PR";
// cover_text = "SADOWA - SAX";
// cover_text = "SADOWA - AH";

general_storage(
  chit_size=chit_size,
  chit_tolerance=chit_tolerance,
  chit_thickness=chit_thickness,
  front_wall_thickness=front_wall_thickness,
  bottom_wall_thickness=1,
  wall_thickness=wall_thickness,
  width=width,
  height=height,
  depth=depth,
  cover=true,
  cover_text=cover_text,
  cover_wall_thickness=cover_wall_thickness,
  cover_text_size=8,
  render_cover_separate=true,
);
