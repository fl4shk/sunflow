//--------
$fa = 1;
$fs = 0.4;

tol_temp = /*1.0;*/ /*0.8;*/ 0.4;
alpha = tol_temp;
beta = tol_temp / 2.0;
offs = /*0.20*/ 0.1;
rnd = 2;


//--------
bx = [
    10,     // b0
    3,      // b1
    6,      // b2
];

w0_temp = 15;
wx = [
    //bx[0],  // 
    w0_temp,     // w0
    w0_temp - 2 * bx[2],
];

//h2_temp = 3;
hx_temp = [
    3,      // h0
    8,      // h1
    3,      // h2
    3,      // h3
];
hx = [
    hx_temp[0],
    hx_temp[1],
    hx_temp[2],
    hx_temp[3],
    hx_temp[1] - hx_temp[2] - hx_temp[3] - (hx_temp[0] + beta),
];

//union(){
//    linear_extrude(hx[1]){
//        square([bx[0], wx[0]]);
//    }
//}

//difference(){
//    minkowski()
//    //hull()
//    {
//        cube([bx[0], wx[0], hx[1]], center=true);
//        cylinder(r=rnd, center=true);
//    }
//    minkowski(){
//        union(){
//            linear_extrude(8){
//                //translate([-4, -4, hx[3]])
//                    square([8, 8]);
//            }
//        }
//        cylinder(r=rnd, center=true);
//    }
//}

//difference(){
//    linear_extrude(hx[1]){
//        offset(r=rnd) offset(delta=-rnd)
//        square([bx[0], wx[0]]);
//    }
//    union(){
//        linear_extrude(hx[1] /* - hx[3]*/ ){
//            translate([bx[2] - bx[1], 0, hx[3]])
//                square([bx[0] - bx[2], wx[0] - bx[1]]);
//        }
//    }
//}
