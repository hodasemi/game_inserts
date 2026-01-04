outer_radius = 10;
inner_radius = 6.5;
lock_radius = 4;
lock_tolerance = 1.2;
lock_height_tolerance = 0.2;

knob_thickness = 1;
lock_thickness = 1.5;

module outer() {
  cylinder(h=knob_thickness, r=outer_radius, $fn=100);

  translate([0, 0, knob_thickness])
    render() difference() {
        cylinder(h=lock_thickness, r=inner_radius, $fn=100);

        cylinder(h=lock_thickness, r=lock_radius, $fn=6);
      }
}

module inner() {
  cylinder(h=knob_thickness, r=outer_radius, $fn=100);

  translate([0, 0, knob_thickness])
    cylinder(h=lock_thickness - lock_height_tolerance, r=lock_radius - (lock_tolerance / 2), $fn=6);
}

outer();

translate([2.5 * outer_radius, 0, 0])
  inner();
