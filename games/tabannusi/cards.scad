module og() {
  import("Cards.stl");
}

render() difference() {
    og();

    card_width = 68;
    card_height = 93;
    thickness = 13.2;
    z_offset = 1.2;

    translate([(126 - card_height) / 2, (89.4 - card_width) / 2, z_offset])
      cube([card_height, card_width, thickness - z_offset]);
  }
