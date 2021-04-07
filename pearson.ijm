// Get the number of pixels in the images. Change "1" to the name of one of your images.
selectWindow("1");

w=getWidth();
h=getHeight();
nPixels=w*h;

// X (change "1" to the name of your first image)
img1_values=newArray();
selectWindow("1")

for(y=0; y<h; y++) {
	for(x=0; x<w; x++) {
		img1_values=Array.concat(img1_values,getPixel(x, y));
	}
}


// Y (change "2" to the name of your second image)
img2_values=newArray();
selectWindow("2")

	for(y=0; y<h; y++) {
		for(x=0; x<w; x++) {
			img2_values=Array.concat(img2_values,getPixel(x, y));
	}
}


// X^2
img1_squared=newArray(0);

for(n=0;n<lengthOf(img1_values);n++) {
	power=img1_values[n]*img1_values[n];
	img1_squared=Array.concat(img1_squared,power);	
}


// Y^2
img2_squared=newArray(0);

for(n=0;n<lengthOf(img2_values);n++) {
	power=img2_values[n]*img2_values[n];
	img2_squared=Array.concat(img2_squared,power);	
}


// X*Y
img1_img2=newArray(0);

for(n=0;n<lengthOf(img1_values);n++) {
	product=img1_values[n]*img2_values[n];
	img1_img2=Array.concat(img1_img2,product);
}



// Sum of X
sum_x=0

for(n=0;n<lengthOf(img1_values);n++) {
	sum_x=sum_x+img1_values[n];
}

// Sum of Y
sum_y=0

for(n=0;n<lengthOf(img2_values);n++) {
	sum_y=sum_y+img2_values[n];
}

// Sum of X*Y
sum_xy=0

for(n=0;n<lengthOf(img1_img2);n++) {
	sum_xy=sum_xy+img1_img2[n];
}

// Sum of X^2
sum_x_squared=0

for(n=0;n<lengthOf(img1_squared);n++) {
	sum_x_squared=sum_x_squared+img1_squared[n];
}

// Sum of Y^2
sum_y_squared=0

for(n=0;n<lengthOf(img2_squared);n++) {
	sum_y_squared=sum_y_squared+img2_squared[n];
}

// Calculate the Pearson correlation coefficient
pearson=((nPixels*sum_xy)-(sum_x*sum_y))/((sqrt(nPixels*sum_x_squared-pow(sum_x,2)))*(sqrt(nPixels*sum_y_squared-pow(sum_y,2))));

print("The Pearson correlation coefficient is: "+pearson);