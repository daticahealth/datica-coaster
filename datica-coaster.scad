// edit these values to parameterize your coaster

height = 3; // mm
// a standard coffee mug is about 90mm wide
logoDiameter = 90; // mm
coasterDiameter = 110; // mm

// don't edit below here

intersection() {
    baseLogo();
    union() {
        linear_extrude(0, 0, height/2)
            circle(d = coasterDiameter, $fn = 60, center = true);
        translate([0, 0, height/2])
            curvedDisk();
    };
}

module baseLogo () {
    color("blue")
        linear_extrude(0, 0, height)
            difference() {
                circle(d = coasterDiameter, $fn = 60, center = true);
                scale(logoDiameter/10, logoDiameter/10, 1)
                    // center the logo - it's off-center a little bit in the source image
                    // internally, it's 10mm x 10mm
                    translate([-5.3, -5.35, 0])
                        import("datica-logo.dxf", center = true);
            };
}

module curvedDisk(segments = 36, radius = height / 2) {
    for (i = [0:segments-1]) {
        previousAngle = 90/segments * (i - 1);
        currentAngle = 90/segments * i;
        translate([0, 0, radius * sin(previousAngle)])
            cylinder(
                h = radius * (sin(currentAngle) - sin(previousAngle)),
                d1 = coasterDiameter - (2 * radius) + (2 * radius * cos(previousAngle)),
                d2 = coasterDiameter - (2 * radius) + (2 * radius * cos(currentAngle)),
                $fn = 60,
                center = false);
    }
}
