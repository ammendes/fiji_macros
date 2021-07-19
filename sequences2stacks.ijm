/*
 * Created by Afonso Mendes in July 2021
 * 
 * This macro merges image sequences into image stacks.
 * 
 * How to use
 * 1. Close all windows in Fiji
 * 2. Select image sequences' parent directory when prompted.
 * 3. Select the directory where to store the final image stacks when prompted.
 * 4. Run the macro and wait for the computation to finish (a message will be displayed in the log).
 */

setBatchMode(false); // Set to "true" to run the macro in the background and get a slight improvement in computation time

// Get Image Sequence master directory
showMessageWithCancel("Please select Image Sequence parent directory");
imagesParentDir = getDir("Image Sequence parent directory");
imagesParentList = getFileList(imagesParentDir);

// Get output stacks master directory
showMessageWithCancel("Please select output stacks parent directory");
stacksParentDir = getDir("Output stacks directory");

// Iterate over all image sequences
print("Processing... Please wait...");
for(i=0; i<imagesParentList.length; i++) {
	// Get directory of the current image sequence
	currentDir = imagesParentDir+imagesParentList[i];
	
	// Import that image sequence as an 8-bit stack
	run("Image Sequence...", "open="+currentDir);

	// Save that stack in the output folder
	if(i<10){
	saveAs("Tiff", stacksParentDir+"00"+i+".tif");
	}else{
	saveAs("Tiff", stacksParentDir+"0"+i+".tif");
	}

	// Close the stack before moving on to the next one
	close("*");
}

print("Done!");
