module og() {
  import("Solo.stl");
}

render() difference() {
    og();

    card_width = 68;
    card_height = 93;
    thickness = 19.5;
    z_offset = 7.3;

    translate([1.2, (89.4 - card_width) / 2, z_offset])
      cube([card_height, card_width, thickness]);
  }
