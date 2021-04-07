// Convert the images to a grayscale format. Default is 32-bit but you can change to "8-bit" or "16-bit" if you desire
selectWindow("1"); // Change "1" to the name of your first image
run("32-bit"); // Change "32-bit2 to "8-bit" or "16-bit" if you desire
selectWindow("2"); // Change "2" to the name of your second image
run("32-bit"); // Change "32-bit2 to "8-bit" or "16-bit" if you desire

// Get total number of pixels
selectWindow("1"); 

w=getWidth()
h=getHeight()
nPixels=w*h

// X
x_values=newArray();

for(y=0;y<h;y++) {
	for(x=0;x<w;x++) {
		x_values=Array.concat(x_values,getPixel(x, y));
	}
}

// Y
selectWindow("2"); 
y_values=newArray();

for(y=0;y<h;y++) {
	for(x=0;x<w;x++) {
		y_values=Array.concat(y_values,getPixel(x, y));
	}
}

// Mean of X
x_sum=0
for(i=0;i<nPixels;i++) x_sum=x_sum+x_values[i];
x_mean=x_sum/nPixels


// Mean of Y
y_sum=0
for(i=0;i<nPixels;i++) y_sum=y_sum+y_values[i];
y_mean=y_sum/nPixels



// Sum of (X - mean_x)*(Y - mean_y)

x_diff=newArray();
y_diff=newArray();
xy_diff_prod=newArray();
xy_diff_prod_sum=0;

for(i=0;i<nPixels;i++) {
	x_diff=Array.concat(x_diff,x_values[i]-x_mean);
	y_diff=Array.concat(y_diff,y_values[i]-y_mean);
	xy_diff_prod=Array.concat(xy_diff_prod,x_diff[i]*y_diff[i]);
	xy_diff_prod_sum=xy_diff_prod_sum+xy_diff_prod[i];
}

// Sum of (X - mean_x) squared
x_diff_squared=newArray();
sum_x_diff_squared=0
for(i=0;i<nPixels;i++) {
	power=x_diff[i]*x_diff[i];
	x_diff_squared=Array.concat(x_diff_squared,power);
	sum_x_diff_squared=sum_x_diff_squared+x_diff_squared[i];
}

// Sum of (Y - mean_y) squared
y_diff_squared=newArray();
sum_y_diff_squared=0
for(i=0;i<nPixels;i++) {
	power=y_diff[i]*y_diff[i];
	y_diff_squared=Array.concat(y_diff_squared,power);
	sum_y_diff_squared=sum_y_diff_squared+y_diff_squared[i];
}

// Calculate Pearson correlation coefficient
pearson=(xy_diff_prod_sum)/(sqrt(sum_x_diff_squared)*sqrt(sum_y_diff_squared));
print("The Pearson correlation coefficient is: "+pearson);