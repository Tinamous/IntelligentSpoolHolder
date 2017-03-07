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
loadCellYOffset = 7;

zZero = 5;

module showSpool() {
    rotate([90,0,0]) {
        difference () {
            union() {
                // Inner perimeter
                cylinder(d=53, h=80);
                // Outer
                cylinder(d=200, h=80);
            }
            union() {
                // Cut out the inner.
                cylinder(d=52, h=80);
            }
        }
    }
}

module showLoadCellModel() {
loadcellHeight = 12.75;
loadcellWidth = 12.75;
loadcellLength = 79.5;
loadCellOffset = -48;
    
    rotate([0,0,90]) {
        translate([loadCellOffset, -(loadcellWidth)/2 ,-0.1]) {
            
            difference() {
                union() {
                    cube([loadcellLength, loadcellWidth, loadcellHeight]);
                    
                    // strain gauge placement + goo
                    translate([(loadcellLength-26)/2,0,loadcellHeight]) {
                        cube([26,loadcellWidth,1]);
                    }
                    translate([(loadcellLength-26)/2,0,-1]) {
                        cube([26,loadcellWidth,1]);
                    }
                    
                    // Bolts
                    translate([0, (12.75/2),0]) {
                        // Project bolts up
                        translate([5.0, 0,0]) {
                            // Bigger top connector holes
                            // to help align with top when visual testing
                            cylinder(d=4, h=40);
                        }
                        translate([20, 0,0]) {
                            cylinder(d=4, h=40);
                        }
                        
                        // Large bolts
                        translate([60, 0,0]) {
                            cylinder(d=5, h=43);
                        }
                        translate([75, 0,0]) {
                            cylinder(d=5, h=43);
                        }
                    }
                }
                union() {
                    translate([5.0, (12.75/2),0]) {
                        // Bigger top connector holes
                        // to help align with top when visual testing
                        //#cylinder(d=4, h=40);
                    }
                    translate([20, (12.75/2),0]) {
                        //#cylinder(d=4, h=40);
                    }
                    //60
                    translate([60, (12.75/2),0]) {
                        cylinder(d=4, h=13);
                    }
                    translate([75, (12.75/2),0]) {
                        //cylinder(d=4, h=13);
                    }
                }
          //  }
        }
    }
    }
}

module showNfcPcb() {
nfcPcbHeight = 5;
    
        
        difference() {
            union() {
                cube([43, 40,1.6]);
                // Dip switch. the tallest thing.
                translate([8.6,8.6,1.6]) {
                    cube([6,4,3]);
                }
                
                // I2C Connection
                translate([5,20-6,-8]) {
                    cube([4,12,8]);
                }
                
                // IRQ and Reset pins
                translate([28,32,-8]) {
                    cube([8,4,8]);
                }
            }
            union() {
                // Mounting holes.                
                translate([43-7.5, 7.5,0]) {
                    #cylinder(d=3, h=nfcPcbHeight+0.01);
                }
                
                translate([7.5, 40-7.5,0]) {
                    #cylinder(d=3, h=nfcPcbHeight+0.01);
                }
            }
        }
}

module spoolConnector() {
    
    // Connect the spool holder to the Ultimaker
    
    difference() {
        union() {
            // This file comes from: http://www.thingiverse.com/thing:399598
            // Licensed under CC Share Alike.
            // https://creativecommons.org/licenses/by-sa/3.0/
            import("Ultimaker2_Reel_Holder_for_40mm_hub_spoolsf825b18387f3bab11ff76988f6d71326-40mm_spool_holder_78mm.stl");
            
            // Surround for the load cell
            translate([-(24/2),-36,0]) {
                cube([24,91,22]);
            }
            
            
            // Stick a cone on the end to get the spool
            // to sit on the main spool holder part.
            translate([0,38,zZero]) {
                rotate([90,0,0]) {
                    // 35.5mm actual diameter.
                    //#cylinder(d1=51, d2=42,h=18);
                    cylinder(d1=58, d2=46,h=12);
                }
            }
            
            // Put in cubes to allow a lower box to be screwed
            // to the part for the elextronics
            translate([0,38,0]) {
                translate([-21,0,0]) {
                  // electronicsBoxMountingCube();
                }
            }
        }
        union() {
            // Cutout for the load cell.
            translate([-(18/2),-28,-0.01]) {
                // 15mm wide + 2mm to one side for wires.
                #cube([18,82,13.1]);
                
                translate([-10,72,0]) {
                    #cube([15,8, 8]);
                }
            }
            
            loadCellFirstHoleYOffset = -26.5 + 6 + 55;
            
            // Load cell screw holes        
            translate([0,loadCellFirstHoleYOffset  ,-1]) {
                #loadCellLargeHole();
            }
            
            translate([0,loadCellFirstHoleYOffset  + 15,-1]) {
                loadCellLargeHole();
            }
            
            // Chop off the main part to allow seperation 
            // and hence flex.
            translate([0,30,5]) {
                rotate([90,0,0]) {
                    // 45mm for spool holder.
                    // + 1mm to cut a gap in the 
                    // cone to float above the spool holder.
                    
                    cylinder(d=45 +1,h=200);
                    //#cylinder(d=70,h=200);
                }
            }
            
            // Slight overlap to remove an extra 1mm clearance between surfaces
            translate([0,69,5]) {
                rotate([90,0,0]) {
                    // 35.5mm actual diameter.
                    //#cylinder(d=35.5,h=20);
                    //#cylinder(d=70,h=50);
                }
            }
            
            // flattern the base
            translate([-60/2,10,-25]) {
               cube([60,60,25]);
            }  
        }
    }
}

module electronicsBoxMountingCube() {
    difference() {
        union() {
            //42
            cube([38,7,10]);
        }
        union() {
            translate([5,3.5,0]) {
                cylinder(d=4.2, h=12);
            }
            translate([37,3.5,0]) {
                cylinder(d=4.2, h=12);
            }
        }
    }
}

module loadCellLargeHole() {
    cylinder(d=6, h=40);
    
    translate([0,0,22]) {
        cylinder(d1=6, d2=10, h=2);
        translate([0,0,2]) {
            cylinder(d=10, h=20);
        }
    }
}



module spoolHolder() {
    
    startY = 20;
    length = 84;
        
     difference() {
          union() {   
            
            // Add new gibber support for 52mm diameter reel.
                // Chop off the main part to allow seperation 
            // and hence flex.
            translate([0,20,zZero]) {
                rotate([90,0,0]) {
                    // 35.5mm actual diameter.
                    cylinder(d=45,h=84);
                    //#cylinder(d=70,h=200);
                }
            }
            
            // Stick a cone on the end to stop the spool falling off.
            translate([0,20-length+0.1,zZero+3]) {
                rotate([90,0,0]) {
                    // 35.5mm actual diameter.
                    cylinder(d1=51, d2=42,h=8);
                    //#cylinder(d=70,h=200);
                }
            }
            
            // Slight overlap to remove an extra 1mm clearance between surfaces
            translate([0,69,zZero]) {
                rotate([90,0,0]) {
                    // 35.5mm actual diameter.
                    //#cylinder(d=35.5,h=20);
                    //#cylinder(d=70,h=50);
                }
            }

        }
        union() {
            
            translate([0,-loadCellYOffset,0]) {
                // Cutout for the load cell.
                translate([-(15/2),-29,-0.01]) {
                    loadCellCutout();      
                }
                
                translate([0,-26.5 + 6, 0]) {
                    loadCellHoles();
                }
            }
            
            // flattern the base
            translate([-55/2,startY-length-10,-25]) {
                cube([55,length+11,25]);
            }   
            
            nfcHoles();
            
            translate([0,0,zZero]) {
                ledHole();
            }
        }
    }
}

module ledHole() {
    translate([0,00,0]) {
        rotate([90,0,0]) {
            cylinder(d=3.2, h=80);        
            translate([0,0,0]) {
                cylinder(d=4.2, h=69);
            }
        }
    }
}

module loadCellCutout() {
    
    cube([15,82,13.1]);
    
    // (middle) 28...53 needs to be wider.
    // and deeper.
    translate([-1,30,-1]) {
        cube([17,52-18,16.1]);
    }
    
    // End (large holes) needs extra space
    // to allow for wires.
    
}

module loadCellHole() {
    // Loadcell screw holw
    cylinder(d=4.5, h=30);
    translate([0,0,18]) {
        cylinder(d1=4.5, d2=8.5, h=2);
        translate([0,0,2]) {
            cylinder(d=8.5, h=12);
        }
    }
}

module loadCellHoles() {
    // Loadcell screws
    translate([0, 0, 0]) {
        loadCellHole();
    }

    translate([0,+15, 0]) {
        loadCellHole();
    }
}

module nfcHole() {
    cylinder(d=4.2, h=26);
    translate([0, 0,6]) {
        // Hole for the nut (nut rather than screw head
        // so the distance past the PCB is fixed.
        // into so that a nut can be used
        // on the PCB rather than using a 
        // brass push fit insert.
        cylinder(d=6.5, h=30,$fn=6);
    }
}

module nfcHoles() {
    
    nfcPcbHeight = 2;

    // -42 to debug.
    translate([-(43/2),-62 -0,0]) {
        // Mounting holes.                
        translate([43-7.5, 7.5,0]) {
            nfcHole();
        }
        
        translate([7.5, 40-7.5,0]) {
            nfcHole();
        }
    }
}

spoolConnector();

translate([0,loadCellYOffset,0]) {
//    spoolHolder();

    // + 50 to offset x
    // -2 or -8  z offset
    translate([-(43/2)+0,-62,-4]) {
    //    %showNfcPcb();
    }

    translate([0,18,5]) {
        //%showSpool();
    }
}

translate([0,22.5,1]) {
  //  %showLoadCellModel();
}



