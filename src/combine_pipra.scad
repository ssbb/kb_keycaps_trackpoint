key_stagger = "corne";
key_profile = "choc";

variation = str(key_profile, "_", key_stagger);

keycaps = [
           "../stl/pipra/bottom_right.stl",
           "../stl/pipra/bottom_right.stl",
           "../stl/pipra/top_right.stl",
           "../stl/pipra/top_right.stl",
           "../stl/pipra/top_left_r2.stl",
           "../stl/pipra/top_left_r3.stl",
           "../stl/pipra/top_left_r2.stl",
           "../stl/pipra/top_left_r3.stl",

];

use <stl_combiner.scad>
combine_stl(keycaps);
