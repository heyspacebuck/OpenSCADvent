// Subsets of the western fonts set
// Each font set maps to ASCII codes 32 and up
include <hershey_western.scad>
use <hershey_parsetools.scad>

western_indices = [for (i = western) getIndex(i)];

function mapIndices(indices) = [for (i=indices) if (len(search(i, western_indices)) > 0) western[search(i, western_indices)[0]]];


// Roman Plain
roman_plain_indices = [
199, 214, 217, 233, 219, 1271, 234, 231, 221, 222, 1219, 225, 211, 224, 210, 220, each [200:209], 212, 213, 1241, 226, 1242, 215, 1273, each [1:26], 1223, 809, 1224, 1262, 997, 230, each [1:26], 1225, 223, 1226, 1246, 218
];
roman_plain = mapIndices(roman_plain_indices);

roman_simplex_indices = [
699, 714, 717, 733, 719, 2271, 734, 731, 721, 722, 2219, 725, 711, 724, 710, 720, each [700:709], 712, 713, 2241, 726, 2242, 715, 2273, each [501:526], 2223, 804, 2224, 2262, 999, 730, each [601:626], 2225, 723, 2226, 2246, 718
];
roman_simplex = mapIndices(roman_simplex_indices);

// Roman Duplex
roman_duplex_indices = [2699, 2714, 2728, 2275, 2719, 2271, 2718, 2717, 2721, 2722, 2723, 2725, 2711, 2724, 2710, 2720, each [2700:2709], 2712, 2713, 2241, 2726, 2242, 2715, 2273, each [2501:2526], 2223, 804, 2224, 2262, 999, 2716, each [2601:2626], 2225, 2229, 2226, 2246, 2729];
roman_duplex = mapIndices(roman_duplex_indices);

// Roman Triplex
roman_triplex_indices = [3199, 3214, 3228, 2275, 3219, 2271, 3218, 3217, 3221, 3222, 3223, 3225, 3211, 3224, 3210, 3220, each [3200:3209], 3212, 3213, 2241, 3226, 2242, 3215, 2273, each [3001:3026], 2223, 804,  2224, 2262, 999,  3216, each [3101:3126], 2225, 2229, 2226, 2246, 3229];
roman_triplex = mapIndices(roman_triplex_indices);

// Roman Complex
roman_complex_indices = [2199, 2214, 2213, 2275, 2274, 2271, 2272, 2251, 2221, 2222, 2219, 2232, 2211, 2231, 2210, 2220, each [2200:2209], 2212, 2213, 2241, 2238, 2242, 2215, 2273, each [2001:2026], 2223, 804, 2224, 2262, 999, 2252, each [2101:2126], 2225, 2229, 2226, 2246, 2218];
roman_complex = mapIndices(roman_complex_indices);
  
// Roman Complex Small
roman_complex_small_indices = [1199, 1214, 1213, 1275, 1274, 1271, 1272, 1251, 1221, 1222, 1219, 1232, 1211, 1231, 1210, 1220, each [1200:1209], 1212, 1213, 1241, 1238, 1242, 1215, 1273, each [1001:1026], 1223, 804,  1224, 1262, 998,  1252, each [1101:1126], 1225, 1229, 1226, 1246, 1218];
roman_complex_small = mapIndices(roman_complex_small_indices);
  
// Script simplex
script_simplex_indices = [699, 2764, 2778, 733, 2769, 2271, 2768, 2767, 2771, 2772, 2773, 725, 2761, 724, 710, 2770, each [2750:2759], 2762, 2763, 2241, 726, 2242, 2765, 2273, each [551:576], 2223, 804, 2224, 2262, 999, 2766, each [651:676], 2225, 723, 2226, 2246, 718];
script_simplex = mapIndices(script_simplex_indices);

// Script complex
script_complex_indices = [2749, 2764, 2778, 2275, 2769, 2271, 2768, 2767, 2771, 2772, 2773, 2775, 2761, 2774, 2760, 2770, each [2750:2759], 2762, 2763, 2241, 2776, 2242, 2765, 2273, each [2551:2576], 2223, 804, 2224, 2262, 999, 2766, each [2651:2676], 2225, 2229, 2226, 2246, 2779];
script_complex = mapIndices(script_complex_indices);

// Gothic English (triplex)
gothic_english_indices = [3699, 3714, 3728, 2275, 3719, 2271, 3718, 3717, 3721, 3722, 3723, 3725, 3711, 3724, 3710, 3720, each [3700:3709], 3712, 3713, 2241, 3726, 2242, 3715, 2273, each [3501:3526], 2223, 804, 2224, 2262, 999, 3716, each [3601:3626], 2225, 2229, 2226, 2246, 3729];
gothic_english = mapIndices(gothic_english_indices);

// Gothic German (triplex)
gothic_german_indices = [3699, 3714, 3728, 2275, 3719, 2271, 3718, 3717, 3721, 3722, 3723, 3725, 3711, 3724, 3710, 3720, each [3700:3709], 3712, 3713, 2241, 3726, 2242, 3715, 2273, each [3301:3326], 2223, 804, 2224, 2262, 999, 3716, each [3401:3426], 2225, 2229, 2226, 2246, 3729];
gothic_german = mapIndices(gothic_german_indices);

// Gothic Italian (triplex)
gothic_italian_indices = [3699, 3714, 3728, 2275, 3719, 2271, 3718, 3717, 3721, 3722, 3723, 3725, 3711, 3724, 3710, 3720, each [3700:3709], 3712, 3713, 2241, 3726, 2242, 3715, 2273, each [3801:3826], 2223, 804, 2224, 2262, 999, 3716, each [3901:3926], 2225, 2229, 2226, 2246, 3729];
gothic_italian = mapIndices(gothic_italian_indices);

// Italic Complex
italic_complex_indices = [2749, 2764, 2778, 2275, 2769, 2271, 2768, 2767, 2771, 2772, 2773, 2775, 2761, 2774, 2760, 2770, each [2750:2759], 2762, 2763, 2241, 2776, 2242, 2765, 2273, each [2051:2076], 2223, 804, 2224, 2262, 999, 2766, each [2151:2176], 2225, 2229, 2226, 2246, 2779];
italic_complex = mapIndices(italic_complex_indices);

// Italic complex small
italic_complex_small_indices = [1199, 1214, 1213, 1275, 1274, 1271, 1272, 1251, 1221, 1222, 1219, 1232, 1211, 1231, 1210, 802, each [1200:1209], 1212, 1213, 1241, 1238, 1242, 1215, 1273, each [1051:1076], 1223, 804, 1224, 1262, 998, 1252, each [1151:1176], 1225, 1229, 1226, 1246, 1218];
italic_complex_small = mapIndices(italic_complex_small_indices);

// Italic Triplex
italic_triplex_indices = [3249, 3264, 3278, 2275, 3269, 2271, 3268, 3267, 3271, 3272, 3273, 3275, 3261, 3274, 3260, 3270, each [3250:3259], 3262, 3263, 2241, 3276, 2242, 3265, 2273, each [3051:3076], 2223, 804, 2224, 2262, 999, 3266, each [3151:3176], 2225, 2229, 2226, 2246, 3279];
italic_triplex = mapIndices(italic_triplex_indices);

greek_simplex = [for (i=[115:138]) western[i], for (i=[192:208]) western[i], western[247], for (i=[209:215]) western[i]];

greek_simplex_small = [for (i=[26:49]) western[i]];

greek_complex = [for (i=[703:726]) western[i], for (i=[780:796]) western[i], western[839], for (i=[797:803]) western[i]];

greek_complex_small = [for (i=[426:449]) western[i], for (i=[502:518]) western[i], western[561], for (i=[519:525]) western[i]];
  
cyrillic_complex = [for (i=[1172:1234]) western[i]];