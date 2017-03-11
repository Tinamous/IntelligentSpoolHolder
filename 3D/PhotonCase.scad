caseWidth = 49;
caseLength = 110;
wallWidth = 1.5;
$fn = 60;

module showLoadCellPcb() {
    loadCellPcbSpaceBetweenHoles = 18;
    
    cube([23, 30, 6]);
    
    translate([2.5,2.5, -3]) {
        cylinder(d=2, h=20);
        
        translate([0,25, 0]) {
            cylinder(d=2, h=20);
        }
    }
    
    // 15mm gap between screws
    
    translate([2.5 + loadCellPcbSpaceBetweenHoles,2.5, -3]) {
        cylinder(d=2, h=20);
        
        translate([0,25, 0]) {
            cylinder(d=2, h=20);
        }
    }
}

module showPhotonPcb() {
    cube([44,80,1.6]);
    translate([0,0,-10]) {
        translate([4,4,0]) {
            cylinder(d=3.2, h=40);  
        }
        translate([44-4,4,0]) {
            cylinder(d=3.2, h=40);  
        }
        translate([4,80-4,0]) {
            cylinder(d=3.2, h=40);  
        }
        translate([44-4,80-4,0]) {
            cylinder(d=3.2, h=40);  
        }
    }
    
    // MicroUSB Plug.
    translate([44/2 - 12/2,-10,12]) {
        cube([12, 20,7]);
    }
}

module photonCase() {
    difference() {
        union() {
            cube([caseWidth, caseLength, 28]);
        }
        union() {
            translate([wallWidth, wallWidth, wallWidth]) {
                cube([caseWidth-(wallWidth*2), caseLength-(wallWidth*2), 28]);
            }
            
            wiresInlet();
            screwHolesForSpoolConnector();
            usbBConnectorCutout();
        }
    }
    
    photonPcbMounts();
    loadCellPcbMounts();
}

module photonPcbMount() {
    difference() {
        cylinder(d=6, h=4);
        cylinder(d=4.2, h=4);
    }
}
module photonPcbMounts() {
    
    translate([2, 3, 0.1]) {
        translate([4,4,0]) {
            photonPcbMount();
        }
        translate([44-4,4,0]) {
            photonPcbMount();
        }
        translate([4,80-4,0]) {
            photonPcbMount();
        }
        translate([44-4,80-4,0]) {
            photonPcbMount();
        }
    }
}

module pcbSupport(d) {
    difference() {
        union() {
            cylinder(d=7, h=4);
        }
        union() {
            translate([0,0,1.5]) {
                cylinder(d=d, h=5);
            }
        }
    }
}

module pcbPin() {
    cylinder(d=4, h=4);
    cylinder(d=2, h=5.5);
}

module loadCellPcbMounts() {
loadCellPcbXOffset = -42;
loadCellPcbYOffset = -15;
loadCellPcbWidth = 21;
loadCellPcbSpaceBetweenHoles = 18;
    
    translate([16,107.5,0.1]) {
        rotate([0, 0, -90]) {

            // Front supports (for load cell amplifier)
            //translate([loadCellPcbXOffset,loadCellPcbYOffset,0]) {
                
                // Offset from top right corder for 
                // the pcb hole.
                translate([+2.5,+2.5,0]) {
                    pcbPin(2);
                }
                
                // left hand corner
                translate([+2.5 + loadCellPcbSpaceBetweenHoles, +2.5, 0]) {
                    // Hole for a M3 brass fixing.
                    pcbSupport(4.2);
                }
            //}
            
            translate([0,0+ 25,0]) {
                
                // Offset from top right corder for 
                // the pcb hole.
                translate([+2.5,+2.5,0]) {
                    pcbPin(2);
                    
                }
                
                // left hand corner
                translate([+2.5 + loadCellPcbSpaceBetweenHoles, +2.5, 0]) {
                    pcbPin(2);
                }
            }
        }
    }
}

module wiresInlet() {
    translate([caseWidth/2, caseLength - wallWidth, 3]) {
        translate([-12, 0, 0]) {
            cube([5,3,30]);
        }
    }
}

module screwHolesForSpoolConnector() {
    translate([caseWidth/2, caseLength - wallWidth, 23]) {
        translate([16, 0, 0]) {
            rotate([-90,0,0]) {
                #cylinder(d=4.5, h=8);
            }
        }
        translate([-16, 0, 0]) {
            rotate([-90,0,0]) {
                #cylinder(d=4.5, h=8);
            }
        }
    }
}

module usbBConnectorCutout() {
    translate([caseWidth/2 - 16/2,-0.01,17.5]) {
        #cube([16, 3,9]);
    }
}


photonCase();

translate([2,3,6.5]) {
    %showPhotonPcb();
}

translate([16,107.5,6.5]) {
    rotate([0, 0, -90]) {
       % showLoadCellPcb();
    }
}

