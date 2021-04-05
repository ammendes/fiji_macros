nParticles=100; // Number of particles
MAXR=5; // Maximum distance that a particle can move in each step (in pixels)


close("*");
newImage("Untitled", "16-bit black", 200, 200, 1000); // Create the Universe. Default is a 1000-frame stack of 16-bit 200x200 images

setMinAndMax(0, nParticles);
run("  Fire "); // LUT to colour particles

w=getWidth();
h=getHeight();

x0=newArray(nParticles);
y0=newArray(nParticles);

// Initial position of each particle
for (n=0;n<nParticles;n++){
	x0[n]=random*(w-1);
	y0[n]=random*(h-1);
}

// Random motion
// Loop to scroll through all slices of the stack
for(s=1;s<=nSlices();s++) {
	setSlice(s);

	// Nested loop to generate X and Y arrays containing the coordinates of the particles in each frame.
	for (n=0;n<nParticles;n++){
		A=random*MAXR; // Step amplitude
		alpha=random*2*PI; // Step angle (in radians)

		x1=A*cos(alpha)+x0[n]; // Random motion in X
		y1=A*sin(alpha)+y0[n]; // Random motion in Y

		// Conditions to contain particles within the boundaries of the image. Comment-out to allow crossing over the boundaries.
		if(x1<0) x1=abs(x1);
		if(y1<0) y1=abs(y1);
		if(x1>(w-1)) x1=(w-1)-(x1-(w-1));
		if(y1>(h-1)) y1=(h-1)-(y1-(h-1));
		
		// Condition for particles within the boundaries + command to paint particles
		if(x1>=0 && y1>=0 && x1<w && y1<h) setPixel(x1, y1, n);

		// Store the current position of each particle, overwriting the previous
		x0[n]=x1;
		y0[n]=y1;	
	}
}		