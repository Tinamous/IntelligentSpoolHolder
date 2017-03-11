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



$fn=120;

// Offset in the spool holder of the load cell.
loadCellYOffset = 5;

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
            }
        }
    }
}

module showNfcPcb() {
nfcPcbHeight = 5;
            
    translate([0,0,0]) {
        // Comment out difference line when showing the model
        // otherwise uncomment for printable model.
        //difference() {
            union() {
                cube([40, 43,1.6]);
                // Dip switch. the tallest thing.
                translate([8.6,43-8-6.6,1.6]) {
                    #cube([5,6,3]);
                }
            }        
            union() {
                // Mounting holes.                
                translate([7.5, 43-7.5,0]) {
                    cylinder(d=3, h=60);
                }
                
                translate([40-7.5, 7.5,0]) {
                    cylinder(d=3, h=60);
                }
                
                // IRQ and Reset pins
                translate([40-8,43-12-15,-2]) {
                    cube([4,15,8]);
                }
                
                
                // I2C Connection, 2mm up and allow 6mm for wires down
                translate([(40/2)-5,43-36.8,-2]) {
                    cube([10,4,8]);
                }
            }
        //}
    }
}

module spoolConnector() {
    
loadCellFirstHoleYOffset = -26.5 + 3.5 + 55;
    
    // Connect the spool holder to the Ultimaker
    
    difference() {
        union() {
            // This file comes from: http://www.thingiverse.com/thing:399598
            // Licensed under CC Share Alike.
            // https://creativecommons.org/licenses/by-sa/3.0/
            //import("Ultimaker2_Reel_Holder_for_40mm_hub_spoolsf825b18387f3bab11ff76988f6d71326-40mm_spool_holder_78mm.stl");
            
            // Use a stripped down version of the connector
            // due to issues with OpenSCAD.
            import("WeightSpool-1.stl");
            
            // Surround for the load cell
            translate([-(24/2),-36,0]) {
                cube([24,91,22]);
            }
            
            // Stick a [cone|cylinder] on the end to get the spool
            // to sit on the main spool holder part.
            translate([0,38,zZero]) {
                rotate([90,0,0]) {
                    // 35.5mm actual diameter.
                    //#cylinder(d1=51, d2=42,h=18);
                    //cylinder(d1=58, d2=46,h=12);
                    // Don't want the spool sitting on the 
                    // ramp as this will alter the weight.
                    cylinder(d1=58, d2=58,h=16);
                }
            }
            
            addChimneys(loadCellFirstHoleYOffset);
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
            
            // Load cell screw holes        
            translate([0,loadCellFirstHoleYOffset  ,-1]) {
                #loadCellLargeHole();
            }
            
            translate([0,loadCellFirstHoleYOffset  + 15,-1]) {
                loadCellLargeHole();
            }
            
            // Chop off the main part to allow seperation 
            // and hence flex.
            translate([0,27.5,5]) {
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
            
            // Holes to mount the electronics box.
            translate([-21,28.5,-0.01]) {
               #electronicsBoxMountingCube();
            }
        }
    }
}

module miniChimney() {
    cylinder(d=8, h=10);
}

module addChimneys(yPosition) {
    translate([0,yPosition,25]) {
        translate([-16,0,0]) {
            miniChimney();
        }
        
        translate([16,0,0]) {
            miniChimney();
        }
    
        translate([0,0,0]) {
            cylinder(d=12, h=23);
        }
    }
    
}

module electronicsCaseScrewHole() {
    cylinder(d=3.5, h=40);
    translate([0,0,5]) {
        cylinder(d=6.5, h=35);
    }
}

module electronicsBoxMountingCube() {
    // Push holes all the way through so we don't get supports
    // and so that a bolt can be inserted from above making it easier
    // to secure the lower bot.
    translate([5,3.5,0]) {
        electronicsCaseScrewHole();
    }
    translate([37,3.5,0]) {
        electronicsCaseScrewHole();
    }
}

module loadCellLargeHole() {
    cylinder(d=6, h=40);
    
    translate([0,0,22]) {
        cylinder(d1=6, d2=10, h=2);
        translate([0,0,2]) {
            cylinder(d=10, h=30);
        }
    }
}

module spoolHolder() {
    
startY = 20;
length = 88;
        
     difference() {
          union() {   
            
            // Add new gibber support for 52mm diameter reel.
                // Chop off the main part to allow seperation 
            // and hence flex.
            translate([0,20,zZero]) {
                rotate([90,0,0]) {
                    // 35.5mm actual diameter.
                    cylinder(d=45,h=length);
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
                translate([-(15/2),-35,-0.01]) {
                    #loadCellCutout();      
                }
                
                translate([0,-26.5 + 3.5, 0]) {
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
                cylinder(d=5, h=69);
            }
        }
    }
    
    // little eye holes to make the led look like a nose.
    translate([10,-74,14]) {
        rotate([90,0,0]) {
            #cylinder(d=5, h=2);
        }
    }    
    translate([-10,-74,14]) {
        rotate([90,0,0]) {
            #cylinder(d=5, h=2);
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
    nutAndBolt = false;
    
    if (nutAndBolt) {
        cylinder(d=4.2, h=26);
        translate([0, 0,6]) {
            // Hole for the nut (nut rather than screw head
            // so the distance past the PCB is fixed.
            // into so that a nut can be used
            // on the PCB rather than using a 
            // brass push fit insert.
            // 6.5mm VERY tight for the nut.
            cylinder(d=7.5, h=30,$fn=6);
        }
    } else {
        #cylinder(d=4.2, h=6);
        translate([0, 0,6]) {
            #cylinder(d1=4.2, d2=0, h=10);
        }
    }
}

module nfcHoles() {
    
    nfcPcbHeight = 2;

    translate([-(40/2),-46, -0.01]) {
        translate([7.5, 43-7.5,0]) {
            nfcHole();
        }
            
        translate([40-7.5, 7.5,0]) {
            #nfcHole();
        }
    }
}

spoolConnector();

translate([0,loadCellYOffset,0]) {
    //spoolHolder();

    // 5mm spacer + 1.2mm pcb
    translate([-(40/2)+0,-46,-(5+1.2)]) {
        %showNfcPcb();
    }

    translate([0,14,5]) {
        //%showSpool();
    }
}

//translate([0,22.5,1]) {
translate([0,20,1]) {
  //  %showLoadCellModel();
}



