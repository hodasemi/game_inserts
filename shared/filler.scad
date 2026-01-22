module filler(width, height, thickness) {
  render() difference() {
      cube([width, height, thickness]);

      translate([width / 2, -1.25 * height, 0])
        cylinder(r=2 * height, h=thickness, $fn=100);
    }
}
