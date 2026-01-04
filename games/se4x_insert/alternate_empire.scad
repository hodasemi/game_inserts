use <../../shared/chit_box.scad>

{
  system_marker = 34; // column 1
  logistic_1 = 5; // column 1
  logistic_2 = 10; // column 1
  home = 2; // column 1

  ms_pipeline = 24; // column 2
  research = 16; // column 2
  decoy = 4; // column 2
  misc = 4; // column 2

  hi = 10; // column 3
  inf = 10; // column 3
  mar = 10; // column 3
  cyber_a = 3; // column 3
  grav = 6; // column 3
  dyo = 6; // column 3
  base = 4; // column 3

  f = 10; // column 4
  mines = 9; // column 4
  miner = 4; // column 4
  minerx = 4; // column 4
  colony_ship = 17; // column 4
  fleet_marker = 5; // column 4

  unique = 6; // column 5
  ds = 4; // column 5
  sw = 6; // column 5
  sc = 6; // column 5
  scx = 1; // column 5
  sy = 7; // column 5
  r = 6; // column 5
  m = 6; // column 5
  sb = 2; // column 5

  dd = 6; // column 6
  ca = 6; // column 6
  bc = 6; // column 6
  bb = 6; // column 6
  dn = 6; // column 6
  t = 6; // column 6
  mb = 6; // column 6
  flagship = 2; // column 6
  titan = 1; // column 6

  // sum = 291 chits
  // 39 different types
}

module alternate_empire_chit_box(
  width,
  height,
  depth,
  ideal_grid_size,
  split = false
) {
  chit_box(
    name="alternate empire",
    width=width,
    height=height,
    depth=depth,
    wall_thickness=0.8,
    chit_tolerance=0.65,
    ideal_grid_size=ideal_grid_size,
    render=split ? [2] : [0, 1],
    info=concat(
      create_column(0, generate_offsets([system_marker, logistic_1, logistic_2]), ["SYS", "LOG1", "LOG2", "HOME"]),
      create_column(1, generate_offsets([ms_pipeline, research, decoy, misc]), ["MS", "RES", "DEC", "MISC"]),
      create_column(2, generate_offsets([hi, inf, mar, cyber_a, grav, dyo]), ["HI", "INF", "MAR", "CYBA", "GRAV", "DYO", "BASE"]),
      create_column(3, generate_offsets([f, mines, miner, minerx, colony_ship]), ["F", "MINES", "MIN", "MINX", "CO", "FM"]),
      create_column(4, generate_offsets([unique, ds, sw, sc + scx, sy, r, m]), ["UN", "DS", "SW", "SC", "SY", "R", "M", "SB"]),
      create_column(5, generate_offsets([dd, ca, bc, bb, dn, t, mb, flagship, titan]), ["DD", "CA", "BC", "BB", "DN", "T", "MB", "FLAG", "TN"]),
    )
  );
}
