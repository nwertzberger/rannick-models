/* Yet Another Arc Library
 * Calculates an arc by cutting apart cylinders. Only good in the z plane.
 * What's kind of nice is that you can jsut specify what the coordinates of
 * your arc should start and end at.
 * Only good up to 180 degrees.
 */

function scalar(vec) = sqrt(pow(vec.x, 2) + pow(vec.y, 2) + pow(vec.z, 2));

module arc(startCoordinates, endCoordinates, degrees, height, width) {
	deltaCoordinates = endCoordinates - startCoordinates;
	currArcLength = scalar(deltaCoordinates);
	radius = currArcLength / (2 * sin(degrees/2));
	
	render() {
		translate(endCoordinates)
			rotate(atan2(-deltaCoordinates.y, -deltaCoordinates.x))
				lineUpArc(currArcLength, degrees, radius, height, width);
		translate(endCoordinates)
			cylinder(h = height, d = width);
		translate(startCoordinates)
			cylinder(h = height, d = width);
	}
}

module lineUpArc(currArcLength, degrees, radius, height, width) {
	outerArcDiameter = radius * 2 + width;
	innerArcDiameter = radius * 2 - width;
	translate([currArcLength/2,-cos(degrees / 2)*radius,0])
		rotate(degrees / 2)
			roughArc(outerArcDiameter, innerArcDiameter, degrees, height);
}

module roughArc(outerArcDiameter, innerArcDiameter, degrees, height) {
	difference() {
		rotate(180 - degrees) difference() {
			hollowCylinder(outerArcDiameter, innerArcDiameter, height);
			translate([-outerArcDiameter / 2, -outerArcDiameter / 2, 0])
			cube([outerArcDiameter / 2, outerArcDiameter, height]);
		}
		translate([-outerArcDiameter / 2, -outerArcDiameter / 2, 0])
			cube([outerArcDiameter / 2, outerArcDiameter, height]);
	}
}

module hollowCylinder(outerArcDiameter, innerArcDiameter, height) {
	difference() {
		cylinder(h = height, d = outerArcDiameter);
		cylinder(h = height, d = innerArcDiameter);
	}
}


// BEGIN TESTS
// Several Different Arcs

translate([0, 0, 0])
	arc([0,0,0], [0,5,0], 30, 7, 1);

translate([20, 0, 0])
	arc([0,0,0],  [0,5,0], 45, 7, 1);

translate([40, 0, 0])
	arc([-5,0,0],  [0,5,0], 90, 7, 1);

translate([60, 0, 0])
	arc([5,0,0],  [0,5,0], 135, 7, 1);

translate([80, 0, 0])
	arc([0,0,0],  [0,5,0], 180, 7, 1);
