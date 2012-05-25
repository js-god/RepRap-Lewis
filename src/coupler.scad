include <measurements.scad>
include <polyholes.scad>
use <components.scad>

module coupler(){
	difference(){
		union(){
			cylinder(r = coupler_diameter/2, h = coupler_height);
			
		}
		translate([0,0,coupler_height/2 + 0.5])poly_cylinder(r = lead_screw_diameter/2, h = coupler_height/2 + 1);
		translate([0,0,-1])poly_cylinder(r = motor_shaft_diameter/2, h = coupler_height/2 - 1.5);
		
		translate([motor_shaft_diameter/2, -nut_apothem, -1])cube([nut_height, nut_apothem*2, coupler_height/4+nut_diameter/2+1]);
		translate([motor_shaft_diameter/2, -nut_apothem, coupler_height*3/4-nut_diameter/2])cube([nut_height, nut_apothem*2, coupler_height/4+nut_diameter/2+1]);
		
		translate([0,0,coupler_height/4])rotate([0,90,0])poly_cylinder(r= screw_diameter/2, h = coupler_diameter/2);
		translate([0,0,coupler_height*3/4])rotate([0,90,0])poly_cylinder(r= screw_diameter/2, h = coupler_diameter/2);
	}
}

module coupler_assembly(){
	union(){
		motor();
		translate([0,0,motor_length+motor_flange_height+motor_shaft_length-coupler_height/2])coupler();
		translate([0,0,motor_length+motor_flange_height+motor_shaft_length])lead_screw(build_height+coupler_height/2+lead_nut_height);
		translate([coupler_diameter/2,0,motor_length+motor_flange_height+motor_shaft_length-coupler_height/4])rotate([0,-90,0])set_screw(coupler_diameter/2);
		translate([coupler_diameter/2,0,motor_length+motor_flange_height+motor_shaft_length+coupler_height/4])rotate([0,-90,0])set_screw(coupler_diameter/2);
		translate([motor_shaft_diameter/2,0,motor_length+motor_flange_height+motor_shaft_length+coupler_height/4])rotate([0,90,0])nut();
		translate([motor_shaft_diameter/2,0,motor_length+motor_flange_height+motor_shaft_length-coupler_height/4])rotate([0,90,0])nut();
	}
}

coupler_assembly();
