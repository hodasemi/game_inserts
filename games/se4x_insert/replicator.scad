use <../../shared/chit_box.scad>

{
  // column 1
  o = 15; // 16
  ii = 15; // 32
  iv = 15; // 48
  v = 8; // 57
  vii = 8; // 66
  ix = 15; // 82
  xi = 8; // 91
  xiii = 6; // 98

  // column 2
  system_marker = 26; // 27
  colony = 12; // 40
  dyo = 6; // 47
  fleet_marker = 6; // 54
  pd = 12; // 67
  sw = 7; // 75
  scan = 6; // 82
  exp = 6; // 89
  xv = 6; // 96
  c64 = 1; // 98

  // 177 chits
  // 18 types
}

module replicator_chit_box(
  width,
  height,
  depth,
  wall_thickness,
  ideal_grid_size,
  split = false,
) {
  // column 1
  c1_offsets = generate_offsets(
    [
      o,
      ii,
      iv,
      v,
      vii,
      ix,
      xi,
      xiii,
    ]
  );

  // column 2
  c2_offsets = generate_offsets(
    [
      system_marker,
      colony,
      dyo,
      fleet_marker,
      pd,
      sw,
      scan,
      exp,
      xv,
      c64,
    ]
  );

  translate([height, 0, 0])
    rotate(90, [0, 0, 1])
      chit_box(
        name="replicator",
        width=width,
        height=height,
        depth=depth,
        wall_thickness=wall_thickness,
        ideal_grid_size=ideal_grid_size,
        render=split ? [2] : [0, 1],
        info=concat(
          create_column(0, generate_offsets([o, ii, iv, v, vii, ix, xi, xiii]), ["O", "II", "IV", "V", "VII", "IX", "XI", "XIII"]),
          create_column(1, generate_offsets([system_marker, colony, dyo, fleet_marker, pd, sw, scan, exp, xv, c64]), ["SYS", "CO", "DYO", "FM", "PD", "SW", "SCAN", "EXP", "XV", "C64"]),
        )
      );
}
