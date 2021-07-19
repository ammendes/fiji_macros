/**
 * Created by Afonso Mendes in July 2021
 * 
 * This macro turns image stacks into its corresponding images.
 *  The macro will create a folder for each image stack in the output parent directory, where it stores the corresponding image sequences.
 * 
 * How to use:
 * 	1. Close all windows in Fiji
 * 	2. Run the macro
 * 	3. When prompted, select the folder where the original image stacks are stored
 * 	4. When prompted, select the parent folder where to save the image sequences
 * 	5. Wait until the computation is finished (log window will display a message).
 */

setBatchMode(false); // Set to "true" to run in the background and get a slight improvement in computation time

// Get the original stacks' directory and file list
showMessageWithCancel("Choose original stacks' directory");
stacksDir = getDir("Choose original stacks' directory");
stacksList = getFileList(stacksDir);

// Get the parent directory to store the image sequences
showMessageWithCancel("Select output directory");
outputDir = getDir("Choose directory to store image sequences");

// Main method
print("Processing. Please wait...");

for (i=0; i<stacksList.length; i++){
	open(stacksDir+stacksList[i]);
	run("Slice Keeper", "first=3 last="+nSlices+" increment=3");
	File.makeDirectory(outputDir+i+"a");
	run("Image Sequence... ", "format=TIFF save="+outputDir+i+"a digits=3");
	close("*");
}

print("Done!");
