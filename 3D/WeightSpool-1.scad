// License: Creative Commons Attribution-ShareAlike 3.0
// https://creativecommons.org/licenses/by-sa/3.0/
// Adaptation of http://www.thingiverse.com/thing:399598
// by Justin (JSquaredZ http://www.thingiverse.com/JSquaredZ/about)

// Changed: Removed mainreel holder to leave only the structure that
// fits the Ultimaker 2. Added new wider reel holder with connection
// via a 5KG load cell and added PCB mounts for a NFC (red) board.

// ====================================================================
// Spool holder for the Ultimaker 2
// Includes a load cell to monitor weight of the spool and a NFC reader
// (red pcb from eBay) to detect which spool is connected.
// ====================================================================



$fn=60;

// Offset in the spool holder of the load cell.
loadCellYOffset = 5;

zZero = 5;

module spoolConnector() {
    
    // Connect the spool holder to the Ultimaker
    
    difference() {
        union() {
            // This file comes from: http://www.thingiverse.com/thing:399598
            // Licensed under CC Share Alike.
            // https://creativecommons.org/licenses/by-sa/3.0/
            import("Ultimaker2_Reel_Holder_for_40mm_hub_spoolsf825b18387f3bab11ff76988f6d71326-40mm_spool_holder_78mm.stl");

        }
        union() {
           
            // Chop off the main part to allow seperation 
            // and hence flex.
            translate([0,37,5]) {
                rotate([90,0,0]) {
                    // 45mm for spool holder.
                    // + 1mm to cut a gap in the 
                    // cone to float above the spool holder.
                    
                    #cylinder(d=50 +1,h=200);
                    //#cylinder(d=70,h=200);
                }
            }
            
        
            
            // flattern the base
            translate([-60/2,10,-25]) {
        //       cube([60,60,25]);
            }  
        }
    }
}


spoolConnector();