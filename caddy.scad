
width = 112;
depht = 90;
hight = 35;

strength = 2.2;

module Box() {
    translate([0,0,hight/2]) {
        difference(){
            cube([width,depht,hight],true);
            translate([0,0,-strength]){
                cube([width-(2*strength),depht+1,hight],true);
            }
            cube([width+10,depht-10,hight-10],true);
            Holes();
        }
    }
    translate([0,depht/2,hight-strength*1.5]){
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
    offset = 10;
    translate([0,depht+offset,hight-strength/2]) {
      difference(){
        cube([width,depht,strength],true);
        Holes();
      }
    }
}

module Holes(){
 translate([10,10,0]) {
     for(w = [-width/2 : width / 5 : width])
        for(d = [-depht/2 : depht / 5 : depht])
            translate([w,d,0]){
               cylinder (h = hight+10, r=4, center = true);
            }   
 }
}

union() {
    Box();
    Bed();
}
