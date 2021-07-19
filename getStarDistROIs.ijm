/*
 * Created by Afonso Mendes in July 2021
 * 
 * This macro runs StarDist2D in image sequences extracted from image stacks to overcome the inability to run the plugin on image stacks. 
 * The image sequences must be extracted before running this macro.
 * The macro saves a file containing the ROI Manager data for each image in each image sequence, allowing the user to recapitulate that ROI Manager at any time.
 * Please save each image sequence in its own folder and store all of these folders in the same parent directory.
 * 
 * NOTE: If StarDist does not produce any ROI in a given image, the image will be deleted from the input directory. ´
 * 		 A text file containing this information will be created in the output parent folder. 
 *
 * 
 * How to use:
 * 1. Select the image sequences' parent directory when prompted.
 * 2. Select the parent directory where to store the ROI Manager data sets.
 * 3. Run the macro and wait until the computation is finished (this may take several minutes).
 * 
 */

setBatchMode(true);

// Get image sequences' parent directory
showMessageWithCancel("Please select image sequences' parent directory");
stacksDir = getDir("Select images' parent directory"); 
stacksList = getFileList(stacksDir);

// Get ROIs' parent directory
showMessageWithCancel("Please select the output ROIs parent directory");
roisMasterDir = getDir("Select directory to store ROI sets");
roisMasterList = getFileList(roisMasterDir);


// MAIN METHOD
print("Processing. Please wait...");

// For each image sequence in the master folder
for (i=0; i<stacksList.length; i++){
	currentStack =i+1;
	print("Processing time lapse " + currentStack + ". Please wait...");
	
	// Get that image sequence's directory and list of files
	slicesDir = stacksDir+stacksList[i];
	slicesList = getFileList(slicesDir);
	
	// Create directory to store corresponding ROIs
	if(i<10) {
		File.makeDirectory(roisMasterDir+"00"+i);
	}else if(i>9 && i<100) {
		File.makeDirectory(roisMasterDir+"0"+i);
	}else{ File.makeDirectory(roisMasterDir+i);
	}
		// For each image in that image sequence
		for (j=0; j<slicesList.length; j++){
			
			//Open the image
			open(slicesDir+slicesList[j]);
			
			// Run StarDist to get ROIs in ROI Manager
			run("Command From Macro", "command=[de.csbdresden.stardist.StarDist2D], args=['input':'"+slicesList[j]+"', 'modelChoice':'Versatile (fluorescent nuclei)', 'normalizeInput':'true', 'percentileBottom':'1.0', 'percentileTop':'99.8', 'probThresh':'0.479071', 'nmsThresh':'0.3', 'outputType':'ROI Manager', 'nTiles':'1', 'excludeBoundary':'2', 'roiPosition':'Automatic', 'verbose':'false', 'showCsbdeepProgress':'false', 'showProbAndDist':'false'], process=[false]");

			// Save those ROIs in the corresponding folder
			if(roiManager("count")>0){
				if(i<10) {
					if(j<10){
						roiManager("Save", roisMasterDir + "00" + i + "/" + "00" + j + ".zip");
					}else if(j>9 && j<100) {
						roiManager("Save", roisMasterDir + "00" + i + "/" + "0" + j + ".zip");
					}else{ 
						roiManager("Save", roisMasterDir + "00" + i + "/" + j + ".zip");
					}
				}else if(i>=10 && i<100) {
					if(j<10){
						roiManager("Save", roisMasterDir + "0" + i + "/" + "00" + j + ".zip");
					}else if(j>9 && j<100) {
						roiManager("Save", roisMasterDir + "0" + i + "/" + "0" + j + ".zip");
					}else{ 
						roiManager("Save", roisMasterDir + "0" + i + "/" + j + ".zip");
					}
				}else{
					if(j<10){
						roiManager("Save", roisMasterDir + i + "/" + "00" + j + ".zip");
					}else if(j>9 && j<100) {
						roiManager("Save", roisMasterDir + i + "/" + "0" + j + ".zip");
					}else{ 
						roiManager("Save", roisMasterDir + i + "/" + j + ".zip");
					}
				}
			
			}else{
				File.delete(slicesDir+slicesList[j]);
				print("Deleted slice " + j + " of stack " + i);
			}
	close("*");
	}
	

}

// Save log containing deleted slices
selectWindow("Log");
saveAs("Text", roisMasterDir+"log.txt");
print("Done!");
