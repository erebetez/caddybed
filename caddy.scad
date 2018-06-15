
// bed
width = 110;
deph = 90;
hight = 35;

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
    bar_v(x,y,h-y);
    translate([0,0,h-y]){
        difference(){
          bar_h(x,y,deph+y/2);
          translate([-1,-0.1,y-3]) {
            bar_t(3.1,3.1,deph+2);
          }
          translate([-1,deph,y-3]) {
            bar_t(y,x,deph+2);
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
    color("green"){
        translate([0,0,hight]){
        Bed(w,d);
        translate([0,0,-3]){
          bar_t(3,3,w);
        }
        translate([y,d-x/2,-y]){
            bar_t(x,y,w-2*y);
        }
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
  color("orange"){
    bar_size = 3;
    Bed(width,deph);
    translate([0,0,-bar_size]) {
        bar_h(bar_size,bar_size,deph-bar_size);
    }
    translate([width-bar_size,0,-bar_size]) {
        bar_h(bar_size,bar_size,deph-bar_size);
    }
    translate([0,deph-bar_size,-bar_size]) {
        bar_t(bar_size,bar_size,width);
    }
  }
}

module CaddyBox2(){
    x = 4;
    y = 8;
    width = 110;
    // deph = 90;
    hight = 35;
    translate([0,0,0]){
      BoxSide(x,y,hight);
    }
    translate([width-x,0,0]){
      BoxSide(x,y,hight);
    }
    BoxTop(width,deph,hight);

    translate([0,deph,hight]){
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
             cube([thinkness+2,80,90],false);
          }
          
        }
    }

    translate([0,0,-thinkness]){
        Base();
        // translate([-thinkness,0,0]){
        //     Side();
        // }
        translate([c_width,0,0]){
            Side();
        }        
    }
        
}

union(){
    // color("blue"){
    //  Caddy();
    // }

    translate([1,5,0]){
      CaddyBox2();
    }
    
}




