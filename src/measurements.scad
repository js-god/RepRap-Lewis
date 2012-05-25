include <configuration.scad>

//Screw Dimension arrays
//[Diameter, Head Height, Head Diameter, nut across flats, lock nut height, nut height, washer od, washer thick]
m2 = [2, 2, 3.8, 4, 2.8, 1.6, 5, 0.3];
m2_5 = [2.5, 2.5, 4.5, 5, 3.8, 2, 6, 0.5];
m3 = [3, 3, 5.5, 5.5, 4, 2.4, 7, 0.6];
m4 = [4, 4, 7, 7, 5, 3.2, 9, 0.9];
m5 = [5, 5, 8.5, 8, 5, 4, 10, 1.1];
m6 = [6, 6, 10, 10, 6, 5, 12.5, 1.8];
m8 = [8, 8, 13, 13, 8, 6.5, 17, 1.8];

//motor dimension arrays
//[width, length, hole spacing, hole diameter, flange diameter, flange height, shaft length, shaft diameter]
nema8 = [20.3, 30, 16, 2, 15, 1.5, 14, 4];
nema11 = [28.1, 27, 23, 2.5, 21, 2, 20, 5];
nema14 = [35.2, 36, 26, 3, 22, 2, 21, 5];
nema17 = [42.3, 48, 31, 3, 22, 2, 23, 5];

// Assign Screw and Lead Screw arrays
screw_array = (screw=="M2") ? m2 : (screw=="M2.5") ? m2_5 : (screw=="M3") ? m3 : (screw=="M4") ? m4 : (screw=="M5") ? m5 : (screw=="M6") ? m6 : (screw=="M8") ? m8 : "error";

lead_screw_array = (lead_screw=="M2") ? m2 : (lead_screw=="M2.5") ? m2_5 : (lead_screw=="M3") ? m3 : (lead_screw=="M4") ? m4 : (lead_screw=="M5") ? m5 : (lead_screw=="M6") ? m6 : (lead_screw=="M8") ? m8 : "error";

//Assign motor array
motor_array = (motor=="NEMA8") ? nema8 : (motor=="NEMA11") ? nema11 : (motor=="NEMA14") ? nema14 : (motor=="NEMA17") ? nema17 : "error";



//echo back the configuration
echo("RepRap Lewis build configuration..."); 

if(screw_array == "error")echo("--Error : invalid screw");
else echo(str("--Screw =  ",screw));

if(lead_screw_array == "error")echo("--Error : invalid lead screw");
else echo(str("--Lead Screw =  ",lead_screw));

if(motor_array == "error")echo("--Error : invalid motor");
else echo(str("--Motor =  ",motor));


//Assign more verbose variables
screw_diameter = screw_array[0];
screw_head_height = screw_array[1];
screw_head_diameter = screw_array[2];

nut_apothem = screw_array[3] / 2;
nut_diameter = screw_array[3] / cos(30);
lock_nut_height = screw_array[4];
nut_height = screw_array[5];

washer_diameter = screw_array[6];
washer_thick = screw_array[7];

lead_nut_apothem = lead_screw_array[3] / 2;
lead_nut_diameter = lead_screw_array[3] / cos(30);
lead_nut_height = lead_screw_array[5];
lead_screw_diameter = lead_screw_array[0];

motor_width = motor_array[0];
motor_length = motor_array[1];
motor_hole_spacing = motor_array[2];
motor_hole_diameter = motor_array[3];
motor_flange_diameter = motor_array[4];
motor_flange_height = motor_array[5];
motor_shaft_length = motor_array[6];
motor_shaft_diameter = motor_array[7];
motor_hole_engagement = motor_hole_diameter *1.5;

coupler_height = motor_shaft_length * 1.5;
coupler_diameter = (motor_shaft_diameter > lead_screw_diameter) ? motor_shaft_diameter * 3 : lead_screw_diameter * 3;

sarrus_top_id = motor_width * sqrt(2) + 2;
sarrus_top_od = sarrus_top_id + 2 + screw_diameter*4;
sarrus_top_thick = screw_diameter * 3;

sarrus_bottom_thick = sarrus_top_thick;

sarrus_link_diameter = sarrus_top_thick;
sarrus_link_length = (build_height + coupler_height + sarrus_top_thick)/2; //longer than needed, but keeps them bent at top
sarrus_link_thick = screw_diameter * 1.5;

//Factoids!!
pi = 3.14159;
build_volume = pi*(pow(build_radius/10,2) - pow(motor_width/10*sqrt(2),2)) * build_height/10;
echo("Factoids...");
echo(str("--Theoretical build volume =  ",build_volume, " cm^3"));

//Start BOM output
echo("Bill Of Materials (parser coming soon)");
