include <caddy.scad>;

// bed
width = 110;
deph = 85;
hight = 38;


union(){
    Caddy("navy");

    translate([1,5,0]){
      CaddyBox2();
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
   // TODO check lenght of box should probably not be greater than 90
    bar_size = 4.1;
    bar_v(x,y,h-y);
    translate([0,0,h-y]){
        difference(){
          bar_h(x,y,deph+y/2);
          translate([-1,-0.1,y-bar_size]) {
            bar_t(bar_size+0.1,bar_size,deph+2);
          }
          translate([-1,deph,y-bar_size]) {
            bar_t(y,y,deph+2);
          }
        }
    }
    translate([0,deph-y/2,0]) {
        bar_v(x,y,h-y);
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
        // Holes(x,y);
    }
}

module Holes(w, d){
 diameter = 2.5;
 distance = diameter * 4;
 translate([distance/2,distance/2,0]) {
     for(w = [-w/2 : w / distance : w])
        for(d = [-d/2 : d / distance : d])
            translate([w,d,0]){
               cylinder (h = hight+10, r=diameter/2, center = true);
            }
 }
}

module BedExtension(){
  deph = 95;
  w = width / 2;
  color("orange"){
    BedWing();
  }
  color("navy"){
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

module CaddyBox2(){
    x = 4;
    y = 8;

    explode = 20;

    translate([0,0,0]){
      BoxSide(x,y,hight);
    }
 // use mirror()
    translate([width-x,0,0]){
      BoxSide(x,y,hight);
    }

    translate([0,0,hight+explode]){
      BoxTop(width,deph,hight);
    }

    translate([0,deph+explode,hight+explode]){
         BedExtension(x);
    }
}

