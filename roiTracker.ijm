/**
 * Created by Afonso Mendes in July 2021
 * 
 * This macro gets an image stack and allows the user to track a single nucleus along time by clicking on it.
 * It requires ROI sets for each frame in the stack stored in a parent folder containing nothing else and named with 3 digits in ascending order.
 * 
 * How to use:
 * 1. Close all windows in Fiji and start the macro.
 * 2. When prompted, select the directory where the ROI sets for a given image stack are stored. 
 * 3. When prompted, select the directory to save the final results.
 * 4. When prompted, select the directory where the image stack is saved.
 * 5. Once the image stack is open, for each frame in the stack, click on the center of your nucleus of interest and press spacebar to move to the next frame.
 * 6. Do not open or close any windows. Wait for processing to finish. A message will be displayed, and the process can be monitored in the status bar.
 * 7. When prompted, type the name of the final results file. 
 * 
 */

// Get ROI sets' parent directory and file list
showMessageWithCancel("Choose the stack's ROI sets' folder.");
roiFolder = getDir("Select ROIs folder");
roiList = getFileList(roiFolder);

// Get parent path to save measurements
showMessageWithCancel("Choose where to save measurements.");
measurementsFolder = getDir("Select where to save measurements");

// Set measurements and create variables needed for later
run("Set Measurements...", "centroid bounding feret's redirect=None decimal=3");
posX = newArray(0);
posY = newArray(0);

// Get the stack's directory and open it
showMessageWithCancel("Choose the stack.");
stack = File.openDialog("Select the stack's directory")
title = File.getNameWithoutExtension(stack);
open(stack);
frames = newArray(0);

// Get reference points for the nucleus in all slices
showMessageWithCancel("For each slice, click on the center of your nucleus of interest and press spacebar to move on to the next slice.");
setTool("point");

for(i=1; i<=nSlices; i++){
	setSlice(i);

	// Wait until "spacebar" is pressed
	showStatus("Waiting for user input... Frame " + i + "/" + nSlices);
	
	while(!isKeyDown("space")){
		wait(50);
	}

	// Get current selection coodinates and update the final coordinates arrays
	showStatus("Saving selection coordinates...");
	
	if(selectionType() != -1){
		getSelectionCoordinates(x, y);
		currentFrame = newArray(1);
		currentFrame[0] = i;
		frames = Array.concat(frames,currentFrame);
		posX = Array.concat(posX,x);
		posY = Array.concat(posY,y);
		run("Select None");
	}else{
		continue;
	}
}

// Prompt the user to initiate processing
showMessageWithCancel("Manual tracking finished. Click OK to start processing.");
print("Processing... Please Wait...");
showStatus("Processing... Please wait...");

// Find ROIs containing the point selections and measure them
for(i=0; i<frames.length; i++){
	showStatus("Processing frame " + (i+1) + "/" + frames.length);
	setSlice(frames[i]);
	
	// Open this frame's StarDist ROI set
	roiManager("Open", roiFolder+roiList[i]);
		
	// For each ROI in this slice, if that ROI contains the point...
	for(r=0; r<roiManager("count"); r++){
		roiFound = false;
		roiManager("select", r);
			
		if(roiFound == false){
			if(Roi.contains(posX[i], posY[i])){
				roiFound = true;
					
				// Get measurements
				run("Measure");
				roiManager("Deselect");

				}else{
					roiManager("Deselect");
					continue;
				}
			}
		}
	roiManager("reset");
}
showStatus("Finished processing!");

// Save the stack's results table
Dialog.create("Save results as...");
Dialog.addString("File name:", "");
Dialog.show();
filename = Dialog.getString();
saveAs("Results", measurementsFolder + filename + ".csv");
print("Measurements saved!");
close("*");
showMessage("Done!");

