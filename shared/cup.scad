module cup(name, size, thickness, text_size) {
  text_inset = 1;

  x_text = is_string(name) ? name : name[0];
  x_metrics = textmetrics(text=x_text, size=text_size);
  x_text_width = x_metrics.size.x;
  x_text_height = x_metrics.ascent;

  y_text = is_string(name) ? name : name[1];
  y_metrics = textmetrics(text=y_text, size=text_size);
  y_text_width = y_metrics.size.x;
  y_text_height = y_metrics.ascent;

  module finger_space() {
    finger_radius = size / 6;

    cylinder(h=thickness, r=finger_radius, $fn=100);

    small_radius = finger_radius / 4;

    translate([finger_radius + small_radius * 7 / 8, small_radius, 0])
      difference() {
        translate([-small_radius, -small_radius, 0])
          cube([small_radius, small_radius, thickness]);

        cylinder(h=thickness, r=small_radius, $fn=100);
      }

    translate([small_radius, finger_radius + small_radius * 7 / 8, 0])
      difference() {
        translate([-small_radius, -small_radius, 0])
          cube([small_radius, small_radius, thickness]);

        cylinder(h=thickness, r=small_radius, $fn=100);
      }
  }

  module info_text(t) {
    rotate(90, [1, 0, 0])
      linear_extrude(height=text_inset)
        text(t, size=text_size);
  }

  render() difference() {
      cube([size, size, thickness]);

      wall_thickness = 1;
      radius = thickness - 2;

      translate([size / 2, size / 2, thickness])
        scale(
          [
            (size / 2 - wall_thickness) / radius,
            (size / 2 - wall_thickness) / radius,
            1,
          ]
        )
          sphere(radius, $fn=250);

      translate([size / 2 - x_text_width / 2, text_inset, thickness / 2 - x_text_height / 2])
        info_text(x_text);

      translate([size / 2 + x_text_width / 2, size - text_inset, thickness / 2 - x_text_height / 2])
        rotate(180, [0, 0, 1])
          info_text(x_text);

      translate([size - text_inset, size / 2 - y_text_width / 2, thickness / 2 - y_text_height / 2])
        rotate(90, [0, 0, 1])
          info_text(y_text);

      translate([text_inset, size / 2 + y_text_width / 2, thickness / 2 - y_text_height / 2])
        rotate(270, [0, 0, 1])
          info_text(y_text);

      finger_space();
      translate([size, 0, 0]) rotate(90, [0, 0, 1]) finger_space();
      translate([0, size, 0]) rotate(270, [0, 0, 1]) finger_space();
      translate([size, size, 0]) rotate(180, [0, 0, 1]) finger_space();
    }
}
