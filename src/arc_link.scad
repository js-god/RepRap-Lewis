include <relations.scad>
include <./Magpie/magpie.scad>
use <./extensions/groove_mount.scad>

module arc_link()
{
  difference()
  {
    union()
    {
      translate([arc_link_length,0,0])cylinder(r=head_od/2, h = arc_link_thick);
      translate([0,-coupler_diameter/2,0])cube([arc_link_length,coupler_diameter,arc_link_thick]);
      cylinder(r = coupler_diameter/2, h = motor_shaft_length);

    }
    translate([arc_link_length-head_od/2,coupler_diameter/2,-eta])cube([head_od,head_od/2,arc_link_thick+eta*2]);
    translate([arc_link_length,0,-eta])cylinder(r=head_id/2, h = arc_link_thick+eta*2);
    translate([0,0,-eta])poly_cylinder(r = motor_shaft_diameter/2, h = motor_shaft_length + eta*2);
    translate([-motor_shaft_diameter/2-nut_height-0.25,-nut_apothem-0.25,-eta])
      cube([nut_height+0.5, nut_apothem*2+0.5, motor_shaft_length/2+eta]);
    translate([-motor_shaft_diameter/2-nut_height-0.25,0,motor_shaft_length/2])
      rotate([0,90,0])cylinder(r=nut_diameter/2+0.25, h= nut_height+0.5, $fn=6);
    translate([0,0,motor_shaft_length/2])rotate([0,-90,0])
    poly_cylinder(r= screw_diameter/2, h = coupler_diameter/2);
    for(i = [0 : 60 : 360])
      {
        translate([arc_link_length,0,-eta])rotate([0,0,i])translate([(head_od+head_id)/4,0,0]){
        poly_cylinder(r=screw_diameter/2, h = arc_link_thick+2);
        rotate([0,0,30])cylinder(r=nut_diameter/2, h = lock_nut_height+eta,$fn=6);
        }
      }
  }
}
module arc_link_assembly()
{
  rotate([0,0,120*$t])
  union()
  {
    arc_link();
    rotate([180,0,0])translate([-motor_shaft_diameter/2-nut_height, 0, -motor_shaft_length/2])rotate([0,90,0])nut(screw);
    rotate([180,0,0])translate([-coupler_diameter/2, 0, -motor_shaft_length/2])rotate([0,90,0])set_screw(screw,coupler_diameter/2);
    translate([build_radius/2,0,arc_link_thick])groove_mount();

  }
}

arc_link();
