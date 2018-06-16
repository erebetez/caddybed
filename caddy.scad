// caddy

module Caddy(color){

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
    color(color){
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
        
}