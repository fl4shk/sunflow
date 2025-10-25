//==============================================================================
//
//           sunflow - DIY USB Game Controller Using a Raspberry Pi Pico
//
// Author:  Andrew Clark (FL4SHK)
// Origin:  https://github.com/fl4shk/sunflow
// License: GPLv3, see LICENSE for terms.
//
//==============================================================================
//--------
$fa = 1;
$fs = 0.4;
include <fillets_and_rounds.scad>

tol_temp = /*1.0;*/ /*0.8;*/ 0.4;
alpha = tol_temp;
beta = tol_temp / 2.0;
offs = /*0.20*/ 0.1;
rnd = 0.5 /*2*/;

//--------
bx_temp = [
    20,     // b0
    2,      // b1
    4,      // b2
];
b3_temp = (
    bx_temp[0] - 2 * bx_temp[2]
);
bx = concat(
    bx_temp,
    [
        b3_temp,                    // b3
        2,                          // b4
        b3_temp + 2 * bx_temp[1],   // b5
    ],
);

w0_temp = 25;
wx_temp = [
    w0_temp,                        // w0
    w0_temp - 2 * bx[2],            // w1
];
wx = concat(
    wx_temp,
    [
        4,                          // w2
        wx_temp[1] + bx[2] + bx[1], // w3
        3,                          // w4
    ]
);

//h2_temp = 3;
hx_temp = [
    3,      // h0
    15,     // h1
    3,      // h2
    3,      // h3
];
hx = concat(
    hx_temp,
    [
        // h4
        hx_temp[1] - hx_temp[2] - hx_temp[3] - hx_temp[0],

        // h5
        3
    ]
);

module cube_hull(cube_sz, sphere_r){
    temp_cube_sz = [
        cube_sz.x - 2 * sphere_r,
        cube_sz.y - 2 * sphere_r,
        cube_sz.z - 2 * sphere_r,
    ];
    sph_pos_arr = [
        for (k=0; k<2; k=k+1) each [
            for (j=0; j<2; j=j+1) each [
                for (i=0; i<2; i=i+1) [
                    i * temp_cube_sz.x + sphere_r,
                    j * temp_cube_sz.y + sphere_r, 
                    k * temp_cube_sz.z + sphere_r,
                ]
            ]
        ]
    ];
    hull(){
        translate([sphere_r, sphere_r, sphere_r])
            cube(temp_cube_sz);
        for (idx = [0 : len(sph_pos_arr) - 1]) {
            translate(sph_pos_arr[idx])
                sphere(sphere_r);
        }
    }
}

add_rounds(R=rnd){
    //add_fillets(){
        difference(){
            cube(
                /*cube_sz=*/[bx[0], wx[0], hx[1]],
                //sphere_r=rnd,
            );
            minkowski(){
                union(){
                    translate([bx[2] - bx[1], 0, hx[3] + hx[4]])
                        cube([
                            2 * bx[1] + bx[3],
                            bx[2] + bx[1] + wx[1],
                            hx[0],
                        ]);
                    translate([bx[2], bx[2], hx[3]])
                        cube([
                            bx[3],
                            wx[1],
                            hx[4],
                        ]);
                    translate([bx[2], 0, hx[3] + hx[4]])
                        cube([
                            bx[3],
                            bx[2] + wx[1],
                            hx[0] + hx[2],
                        ]);
                }
                sphere(r=beta);
            }
        }
    //}
}

translate([bx[0] + 10, 0, 0]){
    add_rounds(R=rnd){
        add_fillets(R=rnd){
            union(){
                cube([bx[5], wx[3], hx[0]]);
                translate([bx[4], wx[4], hx[0]])
                    cube([
                        bx[5] - 2 * bx[4],
                        wx[2],
                        hx[5],
                    ]);
            }
        }
    }
}
