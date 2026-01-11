use <../../shared/chit_storage.scad>
use <../../shared/general_storage.scad>

total_width = 123;
total_height = 293.5;
total_thickness = 24;

small_chit_size = 12.7;
big_chit_size = 15.9;

storage_height = 22;
max_chits_per_column = 11;

function row_offset(row) = 10 + row * 25;

//  ###########  armies  ###########
// central powers
german_armies = 15;
austrian_armies = 9;
turkish_armies = 2;

// allies
italian_armies = 5;
french_armies = 10;
usa_armies = 2;
russian_armies = 13;
serbian_armies = 2;
belgian_armies = 1;
british_armies = 8;

//  ###########  corps  ###########
// central powers
german_corps = 19;
austrian_corps = 11;
turkish_corps = 14;
romanian_corps = 6;

// allies
italian_corps = 7;
french_corps = 10;
usa_corps = 4;
russian_corps = 18;
serbian_corps = 2;
belgian_corps = 1;
british_corps = 15;
bulgarian_corps = 6;
greek_corps = 3;
senussi_corps = 1;

//  ###########  misc  ###########
// big
central_trenches = 27;
allied_trenches = 27;
rp_marker = 10;
fort_marker = 10;
war_status = 3;
mandatory_offensive = 2;
vp_marker = 1;
event_marker = 19;
control_marker = 10;

// small
allied_action = 6;
central_action = 6;
peace_out_marker = 4;
ops_marker = 5;
game_turn = 1;

module named_chit_box(
  name,
  big_count = 0,
  small_count = 0,
  box_height,
  footprint,
) {
  big_columns = ceil(big_count / max_chits_per_column);
  small_columns = ceil(small_count / max_chits_per_column);

  text_size = big_columns + small_columns == 1 ? 7.5 : 15;
  text_depth = 1;
  wall_thickness = 2;
  chit_tolerance = 1;

  big_storage_width = big_columns * (big_chit_size + chit_tolerance) + (big_columns + 1) * wall_thickness;
  small_storage_width = small_columns * (small_chit_size + chit_tolerance) + (small_columns + 1) * wall_thickness;
  height = 2 * wall_thickness + (big_chit_size + chit_tolerance);

  if (footprint) {
    union() {
      tolerance = 1;

      if (big_columns != 0) {
        translate([-tolerance / 2, -tolerance / 2, 0])
          cube([big_storage_width + tolerance, height + tolerance, box_height]);
      }

      if (small_columns != 0) {
        translate([big_storage_width - wall_thickness - tolerance / 2, -tolerance / 2, 0])
          cube(
            [
              small_storage_width + tolerance,
              height + tolerance,
              box_height,
            ]
          );
      }
    }
  } else {
    render() difference() {
        union() {
          // army
          if (big_columns != 0) {
            chit_storage(
              width=big_storage_width,
              height=height,
              depth=box_height,
              wall_thickness=wall_thickness,
              front_wall_thickness=wall_thickness,
              columns=big_columns,
              chit_size=big_chit_size,
              chit_count_per_slot=ceil(big_count / big_columns),
              chit_tolerance=chit_tolerance,
            );
          }

          if (small_columns != 0) {
            translate([big_storage_width - wall_thickness, 0, 0])
              chit_storage(
                width=small_storage_width,
                height=height,
                depth=box_height,
                wall_thickness=wall_thickness,
                front_wall_thickness=wall_thickness,
                columns=small_columns,
                chit_size=small_chit_size,
                chit_count_per_slot=ceil(small_count / small_columns),
                chit_tolerance=chit_tolerance,
              );
          }
        }

        if (!is_undef(name)) {
          metrics = textmetrics(text=name, size=text_size);
          text_width = metrics.size.x;
          text_height = metrics.ascent;

          translate(
            [
              (big_storage_width + small_storage_width + text_width) / 2,
              height - text_depth,
              (box_height - text_height) / 2,
            ]
          )
            rotate(180, [0, 0, 1])
              rotate(90, [1, 0, 0])
                linear_extrude(text_depth)
                  text(name, size=text_size);
        }
      }
  }
}

countries = [
  ["GE", german_armies, german_corps],
  ["AH", austrian_armies, austrian_corps],
  ["TU", turkish_armies, turkish_corps],
  ["RO", 0, romanian_corps],
  [""],
  ["IT", italian_armies, italian_corps],
  ["FR", french_armies, french_corps],
  ["US", usa_armies, usa_corps],
  ["RU", russian_armies, russian_corps],
  ["SR", serbian_armies, serbian_corps],
  ["BE", belgian_armies, belgian_corps],
  ["BR", british_armies, british_armies],
  ["BU", 0, bulgarian_corps],
  ["GR", 0, greek_corps],
  ["SN", 0, senussi_corps],
];

module country_by_index(index, box_height, footprint = false) {
  country = countries[index];
  name = country[0];

  if (name != "") {
    armies = country[1];
    corps = country[2];

    named_chit_box(name=name, big_count=armies, small_count=corps, box_height=box_height, footprint=footprint);
  }
}

module country_by_name(name, box_height, footprint = false) {
  for (i = [0:len(countries) - 1]) {
    country = countries[i];
    country_name = country[0];

    if (country_name == name) {
      country_by_index(i, box_height, footprint);
    }
  }
}

module all_chit_storages(height_offset, footprint) {
  // central_powers
  translate([27, row_offset(0), height_offset]) {
    translate([0, 0, 0]) country_by_name("GE", total_thickness - height_offset, footprint);
  }

  translate([10, row_offset(1), height_offset]) {
    translate([0, 0, 0]) country_by_name("AH", total_thickness - height_offset, footprint);
    translate([36, 0, 0]) country_by_name("RO", total_thickness - height_offset, footprint);
    translate([53, 0, 0]) country_by_name("TU", total_thickness - height_offset, footprint);
  }

  // allies
  translate([7, row_offset(3), height_offset]) {
    translate([0, 0, 0]) country_by_name("IT", total_thickness - height_offset, footprint);
    translate([36, 0, 0]) country_by_name("FR", total_thickness - height_offset, footprint);
    translate([72, 0, 0]) country_by_name("BR", total_thickness - height_offset, footprint);
  }

  translate([1.2, row_offset(4), height_offset]) {
    translate([0, 0, 0]) country_by_name("RU", total_thickness - height_offset, footprint);
    translate([70, 0, 0]) country_by_name("BU", total_thickness - height_offset, footprint);
    translate([86, 0, 0]) country_by_name("GR", total_thickness - height_offset, footprint);
    translate([102, 0, 0]) country_by_name("SN", total_thickness - height_offset, footprint);
  }

  translate([7, row_offset(5), height_offset]) {
    translate([0, 0, 0]) country_by_name("US", total_thickness - height_offset, footprint);
    translate([36, 0, 0]) country_by_name("SR", total_thickness - height_offset, footprint);
    translate([72, 0, 0]) country_by_name("BE", total_thickness - height_offset, footprint);
  }

  // big misc marker
  translate([3, row_offset(7), height_offset]) {
    translate([0, 0, 0]) named_chit_box(big_count=central_trenches, box_height=total_thickness - height_offset, footprint=footprint);
    translate([58, 0, 0]) named_chit_box(big_count=allied_trenches, box_height=total_thickness - height_offset, footprint=footprint);
  }

  translate([3, row_offset(8), height_offset]) {
    translate([0, 0, 0]) named_chit_box(big_count=rp_marker, box_height=total_thickness - height_offset, footprint=footprint);
    translate([20, 0, 0]) named_chit_box(big_count=fort_marker, box_height=total_thickness - height_offset, footprint=footprint);
    translate([40, 0, 0]) named_chit_box(big_count=war_status + mandatory_offensive + vp_marker, box_height=total_thickness - height_offset, footprint=footprint);
    translate([60, 0, 0]) named_chit_box(big_count=event_marker, box_height=total_thickness - height_offset, footprint=footprint);
    translate([96, 0, 0]) named_chit_box(big_count=control_marker, box_height=total_thickness - height_offset, footprint=footprint);
  }

  // small misc marker
  translate([18, row_offset(10), height_offset]) {
    translate([0, 0, 0]) named_chit_box(small_count=allied_action, box_height=total_thickness - height_offset, footprint=footprint);
    translate([17, 0, 0]) named_chit_box(small_count=central_action, box_height=total_thickness - height_offset, footprint=footprint);
    translate([34, 0, 0]) named_chit_box(small_count=peace_out_marker, box_height=total_thickness - height_offset, footprint=footprint);
    translate([51, 0, 0]) named_chit_box(small_count=ops_marker, box_height=total_thickness - height_offset, footprint=footprint);
    translate([68, 0, 0]) named_chit_box(small_count=game_turn, box_height=total_thickness - height_offset, footprint=footprint);
  }
}

// height_offset = 1;

// difference() {
//   cube([total_width, total_height, 8]);
//   all_chit_storages(height_offset=height_offset, footprint=true);
// }

// all_chit_storages(height_offset=height_offset, footprint=false);

tolerance = 2;

width = total_width - tolerance;
height = total_height - tolerance;

chit_tolerance = 1;
chit_thickness = 2;

small_storage_height = height * 1 / 3;

fill_storage_space(
  chit_size=small_chit_size,
  chit_tolerance=chit_tolerance,
  chit_thickness=chit_thickness,
  wall_thickness=1.2,
  front_wall_thickness=1.2,
  bottom_wall_thickness=1,
  fill_parameter=[[width, 2], [small_storage_height, 3], [total_thickness, 2]],
);

translate([0, small_storage_height, 0])
  fill_storage_space(
    chit_size=big_chit_size,
    chit_tolerance=chit_tolerance,
    chit_thickness=chit_thickness,
    wall_thickness=1.2,
    front_wall_thickness=1.2,
    bottom_wall_thickness=1,
    fill_parameter=[[width, 2], [height - small_storage_height, 5], [total_thickness, 2]],
  );

color([0.2, 0.7, 0.2, 0.15]) cube([total_width, total_height, total_thickness]);
