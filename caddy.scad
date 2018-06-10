
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

module BoxSide(pos,x,y,h){
   translate([pos,0,0]){
        bar_v(x,y,h);
        translate([0,y,h-y]){
            bar_h(x,y,deph-y-8/2);
        }
        translate([0,deph-y,0]) {       
            bar_v(x,y,h-8); 
        }
   }
}

module BoxTop(w,d,h){   
    bar = 8;
    color("green"){
        translate([0,0,hight]){
        Bed(w,d);
        translate([0,d-bar/2,-bar]){
            bar_t(bar,bar,w);
        }
        
        }
    }
}

module Bed(x,y){
    strength = 2.2;
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

module CaddyBox2(){
    x = 5.5;
    y = 7.5; 
    width = 110;
    deph = 90;
    hight = 35;
    BoxSide(0,x,y,hight);
    BoxSide(width-x,x,y,hight);
    BoxTop(width,deph,hight);

    translate([0,deph,hight]){
         Bed(width,deph);
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
        translate([-thinkness,0,0]){
            Side();
        }
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




