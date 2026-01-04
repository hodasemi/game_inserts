use <../../shared/chit_box.scad>

{
  system_marker = 34; // column 1 - 35
  logistic_1 = 5; // column 1 - 41
  logistic_2 = 10; // column 1 - 52
  base = 4; // column 1 - 57

  ms_pipeline = 28; // column 2 - 29
  research = 16; // column 2 - 46
  grav = 6; // column 2 - 53
  home = 3; // column 2 - 57

  f = 10; // column 3 - 11
  hi = 10; // column 3 - 22
  inf = 10; // column 3 - 33
  colony_ship = 16; // column 3 - 50
  cv = 6; // column 3 - 57

  mar = 8; // column 4 - 9
  cyber_a = 3; // column 4 - 13
  mines = 9; // column 4 - 23
  miner = 6; // column 4 - 30
  minerx = 4; // column 4 - 35
  misc = 8; // column 4 - 44
  fleet_marker = 5; // column 4 - 50
  dyo = 6; // column 4 - 57

  unique = 6; // column 5 - 7
  ds = 4; // column 5 - 12
  decoy = 4; // column 5 - 17
  bd = 6; // column 5 - 24
  sw = 6; // column 5 - 31
  sc = 6; // column 5
  scx = 1; // column 5 - 39
  sy = 7; // column 5 - 47
  r = 6; // column 5 - 54
  sb = 2; // column 5 - 57

  dd = 6; // column 6 - 7
  ca = 6; // column 6 - 14
  bc = 6; // column 6 - 21
  bb = 6; // column 6 - 28
  dn = 5; // column 6 - 34
  titan = 5; // column 6 - 40
  bv = 6; // column 6 - 47
  t = 6; // column 6 - 54
  flagship = 2; // column 6 - 57

  // sum = 288 chits
  // 40 different types
}

module base_empire_chit_box(
  width,
  height,
  depth,
  ideal_grid_size,
  split = false
) {
  chit_box(
    name="base empire",
    width=width,
    height=height,
    depth=depth,
    wall_thickness=0.8,
    chit_tolerance=0.65,
    ideal_grid_size=ideal_grid_size,
    render=split ? [2] : [0, 1],
    info=concat(
      create_column(0, generate_offsets([system_marker, logistic_1, logistic_2]), ["SYS", "LOG1", "LOG2", "BASE"]),
      create_column(1, generate_offsets([ms_pipeline, research, grav]), ["MS", "RES", "GRAV", "HOME"]),
      create_column(2, generate_offsets([hi, inf, f, colony_ship]), ["HI", "INF", "F", "CO", "CV"]),
      create_column(3, generate_offsets([mar, cyber_a, mines, miner, minerx, misc, fleet_marker]), ["MAR", "CYBA", "MINES", "MIN", "MINX", "MISC", "MARK", "DYO"]),
      create_column(4, generate_offsets([unique, ds, decoy, bd, sw, sc + scx, sy, r]), ["UN", "DS", "DECOY", "BD", "SW", "SC", "SY", "R", "SB"]),
      create_column(5, generate_offsets([dd, ca, bc, bb, dn, titan, bv, t]), ["DD", "CA", "BC", "BB", "DN", "TN", "BV", "T", "FLAG"]),
    )
  );
}
