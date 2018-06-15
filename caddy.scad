
// bed
width = 110;
deph = 85;
hight = 38;

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

// caddy

module Caddy(){
    c_width = 112;
    c_deph = 195;
    c_hight = 130;
    thinkness = 5;

    module Seat(h){
        s_width = width;
        s_deph = 50;
        s_hight = 32;
         cube([s_width,s_deph,s_hight*h],false);
    }

    module Base(){
        translate([0,0,0]) {
            cube([c_width,c_deph,thinkness],false);
        }
        
        translate([0,c_deph/2,thinkness]){
            Seat(1);
        }    
        
        translate([0,c_deph-5,thinkness]){
            Seat(2);        
        }
    }

    module Side(){
        difference(){
          cube([thinkness,c_deph,c_hight],false);
          translate([-1,100,thinkness]){
             cube([thinkness+2,80,110],false);
          }
          
        }
    }

    translate([0,0,-thinkness]){
        Base();
        translate([-thinkness,0,0]){
            Side();
        }
        translate([c_width,0,0]){
            // Side();
        }        
    }
        
}

union(){
    color("blue"){
    //  Caddy();
    }

    translate([1,5,0]){
      CaddyBox2();
    }
    
}




