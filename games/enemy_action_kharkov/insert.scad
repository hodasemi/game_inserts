use <../../shared/general_storage.scad>
use <../../shared/chit_storage.scad>
use <../../shared/spacer.scad>

nozzle_size = 0.6;

og_box_height = 293;
og_box_width = 228;

og_box_wall_thickness = 2;

inner_box_width = og_box_width - 2 * og_box_wall_thickness;
inner_box_height = og_box_height - 2 * og_box_wall_thickness;
inner_box_depth = 53;

tolerance = 2;

sleeve_width = 66.5;
sleeve_height = 92.5;
sleeve_tolerance = 2;

chit_size = 16.7;
chit_tolerance = 2 * nozzle_size;
chit_thickness = 2;

wall_thickness = 2 * nozzle_size;

card_box_height = sleeve_height + 4 * wall_thickness + sleeve_tolerance;

chit_storage(
  chit_size=[sleeve_width, sleeve_height],
  chit_tolerance=sleeve_tolerance,
  chit_thickness=0.7,
  wall_thickness=wall_thickness,
  front_wall_thickness=2 * wall_thickness,
  width=(inner_box_width - tolerance) / 3,
  height=card_box_height,
  depth=inner_box_depth / 2,
  columns=1,
  chit_count_per_slot=34,
  front_wall_width=sleeve_width / 4,
);

translate([0, card_box_height + tolerance, 0])
  generate_spacer(
    fill_parameter=[[inner_box_width - tolerance, 2], [inner_box_height - card_box_height - tolerance, 2], [inner_box_depth / 2, 1]],
    single_for_printing=false,
  );

translate([0, card_box_height + tolerance, inner_box_depth / 2])
  fill_storage_space(
    chit_size=chit_size,
    chit_tolerance=chit_tolerance,
    chit_thickness=chit_thickness,
    wall_thickness=2 * wall_thickness,
    front_wall_thickness=2 * wall_thickness,
    bottom_wall_thickness=1,
    fill_parameter=[[inner_box_width - tolerance, 2], [inner_box_height - card_box_height - tolerance, 4], [inner_box_depth / 2, 2]],
    finger_space_width=13,
    single_for_printing=false,
  );
