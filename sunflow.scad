//--------
$fa = 1;
$fs = 0.4;

tol_temp = /*1.0;*/ /*0.8;*/ 0.4;
alpha = tol_temp;
beta = tol_temp / 2.0;
offs = /*0.20*/ 0.1;
rnd = 0.2 /*2*/;

//include <roof>;

//include <roof>

//--------
bx_temp = [
    20,     // b0
    2,      // b1
    4,      // b2
];
bx = concat(
    bx_temp,
    [
        // b3
        bx_temp[0] - 2 * bx_temp[2],
    ],
);

w0_temp = 25;
wx = [
    //bx[0],  // 
    w0_temp,     // w0
    w0_temp - 2 * bx[2],
];

//h2_temp = 3;
hx_temp = [
    3,      // h0
    20 + beta,     // h1
    3,      // h2
    3,      // h3
];
hx = concat(
    hx_temp,
    [
        // h4
        hx_temp[1] - hx_temp[2] - hx_temp[3] - (hx_temp[0] + beta),
    ]
);

//echo(hx[4]);

//echo(
//    bx[2] - bx[1]
//);
//echo(
//    bx[1]
//);
//echo(
//    bx[3]
//);
//echo(
//    2 * bx[1] + bx[3]
//);
//echo(
//    wx[1]
//);
difference(){
    cube([bx[0], wx[0], hx[1]]);
    union(){
        translate([bx[2] - bx[1], 0, hx[3] + hx[4]])
            minkowski(){
                minkowski(){
                    union(){
                        minkowski(){
                            cube([
                                2 * bx[1] + bx[3],
                                bx[2] + bx[1] + wx[1],
                                hx[0] + beta,
                            ]);
                            union(){
                                cylinder(r=rnd);
                            }
                        }
                    }
                    union(){
                        rotate([0, 90, 0])
                            cylinder(r=rnd);
                    }
                }
                union(){
                    rotate([90, 0, 0])
                        cylinder(r=rnd);
                }
            }
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
                hx[0] + beta + hx[2],
            ]);
        //translate([bx[2] - bx[1], 0, hx[3] + hx[4]])
        //    cube([
        //        2 * bx[1] + bx[3],
        //        wx[1] + bx[2] + bx[1],
        //        hx[0] + beta,
        //    ]);
        //translate([bx[2], bx[2], hx[3]])
        //    cube([
        //        bx[3],
        //        wx[1],
        //        hx[4],
        //    ]);
        //translate([bx[2] - bx[1], 0, hx[3] + hx[4]])
        //    cube([
        //        bx[0] - 2 * (bx[2] - bx[1]),
        //        //wx[1] + bx[2],
        //        //hx[0] + beta,
        //    ]);
        ////translate([bx[2], 0, hx[3] + hx[4]])
        ////    cube([
        ////        bx[0] - 2 * bx[2],
        ////        wx[1] + bx[2],
        ////        hx[0] + beta + hx[2]
        ////    ]);
        //translate([bx[2], bx[2], hx[3]])
        //    cube([
        //        bx[0] - 2 * bx[2],
        //        wx[1] /*- bx[2]*/,
        //        hx[4],
        //    ]);
    }
}
////roof(){
////    linear_extrude(5){
////        //translate([0, 0])
////            square([8, 8]);
////    }
////}
//
////union(){
////    linear_extrude(hx[1]){
////        square([bx[0], wx[0]]);
////    }
////}
//
////difference(){
////    minkowski()
////    //hull()
////    {
////        cube([bx[0], wx[0], hx[1]], center=true);
////        cylinder(r=rnd, center=true);
////    }
////    minkowski(){
////        union(){
////            linear_extrude(8){
////                //translate([-4, -4, hx[3]])
////                    square([8, 8]);
////            }
////        }
////        cylinder(r=rnd, center=true);
////    }
////}
//
////difference(){
////    linear_extrude(hx[1]){
////        offset(r=rnd) offset(delta=-rnd)
////        square([bx[0], wx[0]]);
////    }
////    union(){
////        linear_extrude(hx[1] /* - hx[3]*/ ){
////            translate([bx[2] - bx[1], 0, hx[3]])
////                square([bx[0] - bx[2], wx[0] - bx[1]]);
////        }
////    }
////}
