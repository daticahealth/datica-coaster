// edit these values to parameterize your coaster

height = 3; // mm
// a standard coffee mug is about 90mm wide
logoDiameter = 90; // mm
coasterDiameter = 110; // mm
bevelRadius = height/2; // mm

// don't edit below here

intersection() {
    baseLogo();
    beveledDisk();
}

module baseLogo () {
    color("blue")
    linear_extrude(0, 0, height)
            difference() {
                circle(d = coasterDiameter, $fn = 60, center = true);
         
                scale(logoDiameter/10, logoDiameter/10, 1)
                    // center the logo - it's off-center a little bit in the source image.
                    // internally, it's 10mm x 10mm.
                    translate([-5.3, -5.35, 0])
                        import("datica-logo.dxf", center = true);
            };
}

module beveledDisk() {
    linear_extrude(0, 0, height/2)
        circle(d = coasterDiameter, $fn = 60, center = true);
    translate([0, 0, height/2])
        cylinder(h = height/2, d1 = coasterDiameter, d2 = coasterDiameter - 2 * bevelRadius, $fn = 60, center = false);
}