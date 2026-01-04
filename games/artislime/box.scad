card_width = 67;
card_height = 91;

card_thickness = 50;

card_tolerance = 2;

wall_thickness = 2.5;

overlap = 20;
overlap_tolerance = 0.3;
top_thickness = 20;

module bottom() {
  render() difference() {
      bottom_total_width = card_width + card_tolerance + 2 * wall_thickness;
      bottom_total_depth = card_thickness + 2 * wall_thickness;
      bottom_total_height = card_height + card_tolerance + wall_thickness - top_thickness - overlap_tolerance;

      translate([-wall_thickness, -wall_thickness, -wall_thickness])
        cube([bottom_total_width, bottom_total_depth, bottom_total_height]);

      cube([card_width + card_tolerance, card_thickness, card_height + card_tolerance]);

      translate([-wall_thickness, -wall_thickness, card_height + card_tolerance - overlap - top_thickness]) difference() {
          cube([bottom_total_width, bottom_total_depth, overlap]);

          translate(
            [
              wall_thickness / 2,
              wall_thickness / 2,
              0,
            ]
          )
            cube(
              [
                card_width + card_tolerance + wall_thickness,
                card_thickness + wall_thickness,
                overlap,
              ]
            );
        }

      text = "SLIME";
      text_size = 13;
      text_inset = 1;

      metrics = textmetrics(text, text_size);
      text_width = metrics.size.x;
      text_height = metrics.ascent;

      translate([-wall_thickness + bottom_total_width / 2 - text_width / 2, text_inset - wall_thickness, bottom_total_height / 2])
        rotate(90, [1, 0, 0])
          linear_extrude(text_inset)
            text(text, text_size);
    }
}

module top() {
  render() translate([-wall_thickness, -wall_thickness, card_height + card_tolerance - top_thickness - overlap])
      difference() {
        cube([card_width + card_tolerance + 2 * wall_thickness, card_thickness + 2 * wall_thickness, wall_thickness + top_thickness + overlap]);

        translate([wall_thickness, wall_thickness, 0])
          cube([card_width + card_tolerance, card_thickness, top_thickness + overlap]);

        translate([wall_thickness / 2 - overlap_tolerance / 2, wall_thickness / 2 - overlap_tolerance / 2, 0])
          cube(
            [
              card_width + card_tolerance + wall_thickness + overlap_tolerance,
              card_thickness + wall_thickness + overlap_tolerance,
              overlap,
            ]
          );

        text = "ARTI";
        text_size = 13;
        text_inset = 1;

        metrics = textmetrics(text, text_size);
        text_width = metrics.size.x;
        text_height = metrics.ascent;

        translate([(card_width + card_tolerance + 2 * wall_thickness) / 2 - text_width / 2, text_inset, (wall_thickness + top_thickness + overlap) / 2 + text_height * 1 / 4])
          rotate(90, [1, 0, 0])
            linear_extrude(text_inset)
              text(text, text_size);
      }
}

top();
// bottom();
