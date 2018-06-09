
width = 112;
depht = 90;
hight = 35;

strength = 2.2;

module BaseForm() {
     union() {

        // box
        translate([0,0,hight/2]) {
            difference(){
                cube([width,depht,hight],true);
                translate([0,0,-strength]){
                    cube([width-(2*strength),depht+1,hight],true);
                }
                cube([width+10,depht-10,hight-10],true);
            }
        }

        // top
        translate([0,depht,hight-strength/2]) {
            cube([width,depht,strength],true);
        }
    }
}

difference(){
 BaseForm();
    
 translate([10,10,hight/2]) {
     for(w = [-width/2 : width / 5 : width])
        for(d = [-depht/2 : depht / 5 : depht*2])    
            translate([w,d,0]){
               cylinder (h = hight+10, r=4, center = true);
            }   
 }
    
}