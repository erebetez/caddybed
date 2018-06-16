include <caddy.scad>;

// bed
width = 110;
deph = 85;
hight = 38;


union(){
    // Caddy("navy");

    translate([1,5,0]){
      CaddyBox();
    }
}

module bar_v(x,y,l){
    color("red"){
      cube([x,y,l],false);
    }
}

module bar_h(x,y,l){
    color("yellow"){
      cube([x,l,y],false);
    }
}

module bar_t(x,y,l){
    color("yellow"){
      cube([l,x,y],false);
    }
}

module BoxSide(x,y,h){
    leg_offset = 10;

    // Front
    translate([0,leg_offset,0]){
        BoxSideLeg(x,y,h);
    }

    translate([0,0,h-y]){
        BoxSideTop(x,y,h,leg_offset);
    }

    // Back
    translate([0,deph-y,0]) {
        BoxSideLeg(x,y,h);
    }
}

module BoxSideTop(x,y,h,leg_offset){
    bar_size = 4.1;
    difference(){
        bar_h(x,y,deph+y/2);

        translate([-0.1,-0.1,y-bar_size]) {
          bar_t(bar_size+0.1,bar_size+0.1,deph+2);
        }
        translate([-0.1,deph,y-bar_size]) {
          bar_t(y,y,deph+2);
        }

        // Front
        translate([0,leg_offset+y/2,x]) {
          FixHole(180);
        }
        // Back
        translate([0,deph-y/2,x]) {
          FixHole(180);
        }
    }
}

module BoxSideLeg(x,y,h) {
    difference(){
        bar_v(x,y,h-y);
        translate([0,y/2,h-y-x]) {
            FixHole(0);
        }
    }
}

module FixHole(orientation){
    radius = 1.25;

    rotate(orientation,[1,0,0]) {
        translate([-radius,-radius,0]){
            cube([10,radius*2,radius],false);
        }

        rotate(90, [0,1,0]) {
            cylinder (h = 10, r=radius, center = true, $fn=50);
        }
    }
}

module BoxTop(w,d,h){
    x = 8;
    y = 4;
    bar_size = 4.1;
    color("green"){
        Bed(w,d/2);
        translate([0,0,-bar_size]){
          bar_t(bar_size,bar_size,w);
        }
        translate([y,d-x/2,-y]){
          bar_t(x,y,w-2*y);
        }
    }
    color("olive"){
        translate([0,d/2,0]) {
             Bed(w,d/2);
        }
    }
}

module Bed(x,y){
    strength = 1.2;
    difference(){
        cube([x,y,strength],false);
        Holes(x,y);
    }
}

module Holes(wi, di){
 diameter = 2.5;
 distance = diameter * 6;
 translate([distance/2,distance/2,0]) {
     for(w = [-wi/2 : distance : wi-distance])
        for(d = [-di/2 : distance : di-distance])
            translate([w,d,0]){
               cylinder (h = 5, r=diameter/2, center = true, $fn=50);
            }
 }
}

module BedExtension(){
  deph = 95;
  w = width / 2;
  color("orange"){
    BedWing();
  }
  color("OrangeRed"){
    translate([w,0,0]){
        BedWing();
    }
  }
}

module BedWing(){
    deph = 95;
    w = width / 2;
    bar_size = 4.1;
    Bed(w,deph);
    translate([0,0,-bar_size]) {
        bar_h(bar_size,bar_size,deph-bar_size);
    }
    translate([w-bar_size,0,-bar_size]) {
        bar_h(bar_size,bar_size,deph-bar_size);
    }
    translate([0,deph-bar_size,-bar_size]) {
        bar_t(bar_size,bar_size,w);
    }
}

module CaddyBox(){
    x = 4;
    y = 8;

    explode = 0;

    translate([0,0,0]){
      BoxSide(x,y,hight);
    }

    translate([width,0,0]){
      mirror(){
         BoxSide(x,y,hight);
      }
    }

    translate([0,0,hight+explode]){
      BoxTop(width,deph,hight);
    }

    translate([0,deph+explode,hight+explode]){
      BedExtension();
    }
}

