include <measurements.scad>
use <components.scad>
use <polyholes.scad>

module arc_link(){
	difference(){
		union(){
			translate([arc_link_length,0,0])cylinder(r=head_od/2, h = arc_link_thick);
			
			translate([0,-coupler_diameter/2,0])cube([arc_link_length,coupler_diameter,arc_link_thick]);
			cylinder(r = coupler_diameter/2, h = motor_shaft_length);
			
		}
		translate([arc_link_length,0,-1])rotate([0,0,45])cube([head_od/2,head_od/2,arc_link_thick+2]);
		translate([arc_link_length,0,-1])cylinder(r=head_id/2, h = arc_link_thick+2);
		translate([0,0,-1])poly_cylinder(r = motor_shaft_diameter/2, h = motor_shaft_length + 2);
		
		translate([-motor_shaft_diameter/2-nut_height, -nut_apothem, -1])cube([nut_height, nut_apothem*2, coupler_height/2+nut_diameter/2+1]);
		translate([0,0,motor_shaft_length/2])rotate([0,-90,0])poly_cylinder(r= screw_diameter/2, h = coupler_diameter/2);
		for(i = [0 : 60 : 360]){
			translate([arc_link_length,0,-1])rotate([0,0,i])translate([(head_od+head_id)/4,0,0])poly_cylinder(r=screw_diameter/2, h = arc_link_thick+2);
		}
	}
}
module arc_link_assembly(){
	rotate([0,0,360*$t])
	union(){
		rotate([180,0,0])arc_link();
		translate([-motor_shaft_diameter/2-nut_height, 0, -motor_shaft_length/2])rotate([0,90,0])nut();
		translate([-coupler_diameter/2, 0, -motor_shaft_length/2])rotate([0,90,0])set_screw(coupler_diameter/2);
	}
}

arc_link_assembly();