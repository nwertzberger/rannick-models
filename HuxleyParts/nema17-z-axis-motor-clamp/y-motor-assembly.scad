use<arc.scad>;

module drawMotorAssembly(height, spacing, screwHoleDiameter, thickness) {
	motorHoleDiameter = sqrt(spacing * spacing * 2);
	motorHoleRadius = motorHoleDiameter / 2;
	difference() {
		arc([motorHoleRadius, 0, 0],
			[-motorHoleRadius, 0, 0],
			180, height, thickness * 2 + screwHoleDiameter);
		drawMotorScrews(height, motorHoleDiameter, screwHoleDiameter);
	}
}

module drawMotorScrews(height, motorHoleDiameter, screwHoleDiameter) {
	translate([motorHoleDiameter / 2,0,0])
		cylinder(h = height, d = screwHoleDiameter);
	translate([-motorHoleDiameter / 2,0,0])
		cylinder(h = height, d = screwHoleDiameter);
	translate([0, motorHoleDiameter / 2, 0])
		cylinder(h = height, d = screwHoleDiameter);
}


drawMotorAssembly(5, 30, 3, 3);
