
// bed
width = 112;
deph = 90;
hight = 35;

strength = 2.2;

module Box() {
    translate([0,0,hight/2]) {
        difference(){
            cube([width,deph,hight],true);
            translate([0,-strength,-strength]){
                cube([width-(2*strength),deph+1,hight],true);
            }
            cube([width+10,deph-10,hight-10],true);
            cube([width-10,deph+10,hight-10],true);
            Holes();
        }
    }
    translate([0,deph/2,hight-strength*1.5]){
      union(){
        cube([width-strength*2,8,strength],true);
        for(w = [-1 : 1 : 1])
          translate([(w*width/2)-(w*strength*2),2,strength/2]){
            cylinder (h = strength, r=1, center = true);
          }
      }
    }
}

module Bed(){
    offset = 0.5;
    translate([0,deph+offset,hight-strength/2]) {
      difference(){
        cube([width,deph,strength],true);
        Holes();
      }
    }
}

module Holes(){
 translate([10,10,0]) {
     for(w = [-width/2 : width / 5 : width])
        for(d = [-deph/2 : deph / 5 : deph])
            translate([w,d,0]){
               cylinder (h = hight+10, r=4, center = true);
            }   
 }
}

module CaddyBox(){
    union() {
        Box();
        Bed();    
    }
}

// caddy
c_width = 112;
c_deph = 195;
c_hight = 150;
thinkness = 10;

//seat
s_width = 110;
s_deph = 50;
s_hight = 32;

module Caddy(){
    color("blue")
    translate([0,0,0]) {
        cube([c_width,c_deph,thinkness],false);
    }
    color("blue")
    translate([0,c_deph/2,thinkness]){
        cube([s_width,s_deph,s_hight],false);
    }    
    color("blue")
    translate([0,c_deph-5,thinkness]){
        cube([s_width,s_deph,s_hight*2],false);
    }
}

union(){
    Caddy();
    translate([width/2,deph/2+5,thinkness]){
      CaddyBox();
    }    
}



