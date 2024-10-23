// The cutter expects keycaps to be centered at origin,
// but the cs keycaps stls are not.
// So here we adjust for that
cs_translate = [0, 0, 0];

// keycap_array_format = [
//    stl_path,
//    translate_adjustment,
//    rotation_adjustment,
//    mirror_adjustment,
// ]
cs_r2_lateral_top_r = [
   "../keycaps/pipra/cs_r2_lateral_l.stl",

   // By default the r2_lateral key is rotated for the bottom row
   // here we rotate it for the top row
   cs_translate, [0, 0, 0], [1, 0, 0]
];
cs_r2_lateral_top_l = [
   "../keycaps/pipra/cs_r2_lateral_l.stl",

   // By default the r2_lateral key is rotated for the bottom row
   // here we rotate it for the top row.
   // On top of that we mirror it to create the version for the left side
   cs_translate, [0, 0, 0], [0, 0, 0]
];
cs_r2_lateral_top_l_rot = [
   "../keycaps/pipra/cs_r2_lateral_l_rot.stl",

   // By default the r2_lateral key is rotated for the bottom row
   // here we rotate it for the top row.
   // On top of that we mirror it to create the version for the left side
   cs_translate, [0, 0, 0], [0, 0, 0]
];
cs_r3_lateral_l = [
   "../keycaps/pipra/cs_r3_lateral_l.stl",

   // By default the r3_lateral key is rotated for the bottom row
   // here we rotate it for the top row
   // On top of that we mirror it to create the version for the left side
   cs_translate, [0, 0, 180], [1, 0, 0]
];
cs_r3_lateral_l_rot = [
   "../keycaps/pipra/cs_r3_lateral_l_rot.stl",

   // By default the r3_lateral key is rotated for the bottom row
   // here we rotate it for the top row
   // On top of that we mirror it to create the version for the left side
   cs_translate, [0, 0, 0], [0, 0, 0]
];
cs_r3_lateral_r  = [
   "../keycaps/pipra/cs_r3_lateral_l.stl",

   // By default the r3_lateral key is rotated for the bottom row
   // here we rotate it for the top row
   // On top of that we mirror it to create the version for the left side
   cs_translate, [0, 0, 180], [0, 0, 0]
];
cs_r3_lateral_r_rot  = [
   "../keycaps/pipra/cs_r3_lateral_l_rot.stl",

   // By default the r3_lateral key is rotated for the bottom row
   // here we rotate it for the top row
   // On top of that we mirror it to create the version for the left side
   cs_translate, [0, 0, 180], [0, 0, 0]
];
cs_r3_lateral_r_dot = [
   "../keycaps/pipra/cs_r3_lateral_r_dot.stl",

   // This is already correctly rotated and we don't need to do anything
    cs_translate, [0, 0, 0], [0, 0, 0]
];
