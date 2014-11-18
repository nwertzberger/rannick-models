use<arc.scad>;

module clipMouth(height, mouthWidth, clipDiameter) {
	cylinder(h = height, d = mouthWidth);
	translate([-mouthWidth / 2, 0, 0])
		cube([mouthWidth, clipDiameter/2, height]);
}
module clipFill(height, clipHeadDiameter, clipSeparation, fillWidth) {
	//Clip heads
	cylinder(h = height, d = clipHeadDiameter);
	translate(clipSeparation)
		cylinder(h = height, d = clipHeadDiameter);

	// Filler
	arc([0,0,0], clipSeparation, 120, height, clipHeadDiameter);

}

module clipAssembly(
	height, clipSeparation, clipHeadDiameter, mouthWidth) {
	difference() {
		clipFill(height, clipHeadDiameter, clipSeparation, mouthWidth);
		clipMouth(height, mouthWidth, clipHeadDiameter);
		translate(clipSeparation)
			clipMouth(height, mouthWidth, clipHeadDiameter);
	}
}

clipAssembly(5, [30, 5, 0], 20, 5);
