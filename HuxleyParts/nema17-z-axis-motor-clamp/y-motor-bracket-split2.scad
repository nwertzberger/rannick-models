$fn=40;

use<y-motor-assembly.scad>;
use<y-clip-assembly.scad>;
use<arc.scad>;

// Settings for this assembly.
// Everything is in millimeters.
clipWidth = 6.5;
clipSeparation = [32 + clipWidth / 2, 5, 0];

clipHeadDiameter = 20;

screwHoleDiameter = 3;
wirePortDiameter = 9;
beltSpace = 3;
thinWidth = 4;
beltWidth = 7;
minimumThickness = 3;

motorHoleSpacing = 34 - screwHoleDiameter / 2;

motorHoleDiameter = sqrt(motorHoleSpacing *motorHoleSpacing * 2);

assemblyBottom = - motorHoleDiameter / 2
			- minimumThickness
			- screwHoleDiameter / 2;

assemblyTop = motorHoleDiameter/2;

panelWidth = thinWidth + beltWidth;

motorHoleDiameter = sqrt(motorHoleSpacing * motorHoleSpacing * 2);
outerMotorHoleDiameter = motorHoleDiameter
	+ minimumThickness
	+ screwHoleDiameter;

motorTwist = -9;

barThickness = clipHeadDiameter / 2 - clipWidth /2;

module drawFilledPanel() {

	
	difference() {
		translate([assemblyBottom + clipHeadDiameter / 2 , motorHoleSpacing, 0]) {
	    		clipAssembly(
				panelWidth,
				clipSeparation,
				clipHeadDiameter,
				clipWidth);
		}
		cylinder(h = panelWidth, d = outerMotorHoleDiameter);
	}
	rotate([0,0,motorTwist])
	drawMotorAssembly(
		panelWidth,
		motorHoleSpacing,
		screwHoleDiameter,
		minimumThickness);

	difference() {
		translate([assemblyBottom,
				screwHoleDiameter / 2 - motorHoleDiameter/2 * sin(motorTwist),
				0])
			cube([barThickness,
				motorHoleDiameter / 2 + clipHeadDiameter / 2 + motorHoleDiameter/2 * sin(motorTwist),
				panelWidth]);
		translate([-motorHoleDiameter / 2, 0, 0])
			cylinder(h = panelWidth, d = screwHoleDiameter);
	}
	difference() {
		arc(	[	assemblyTop - 1,
				motorHoleDiameter / 2 + clipHeadDiameter/2 - clipWidth/2,
				0],
			[assemblyTop, 0,0],
			45, panelWidth, barThickness );
		rotate([0,0,motorTwist])
		translate([motorHoleDiameter / 2, 0, 0])
			cylinder(h = panelWidth, d = screwHoleDiameter);
	}
}

difference() {
	drawFilledPanel();
	rotate([0,0,-26])
	translate([ 0, motorHoleDiameter/2 - screwHoleDiameter/2 + minimumThickness, 0])
		cylinder(h = panelWidth, d = wirePortDiameter);
	translate([3,0,thinWidth])
		rotate([0,0,-34])
			cube([beltSpace, 100, beltWidth]);

	translate([-3 - beltSpace,0,thinWidth])
		rotate([0,0,-10])
			cube([beltSpace, 100, beltWidth]);

	translate([assemblyBottom + clipHeadDiameter / 2, motorHoleSpacing, thinWidth] + clipSeparation) {
		cylinder(h = beltWidth, d = clipHeadDiameter + 3);
	}
	
}


