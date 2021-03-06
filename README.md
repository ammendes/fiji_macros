# fiji_macros

A compilation of Fiji macros developed by me.


## How to use the macros

1. Read each macro's notes to ensure everything is properly set up in your machine.
2. Download the file.
3. Open Fiji.
4. Go to "Plugins -> Macros -> Run" to run the macros or "Plugins -> Macros -> Edit" to edit/view them.
5. Select the file and click "Open".

## List of macros (and what they do):

#### `brownian_contained.ijm`
Creates an image stack (default is 16-bit, 200x200, 1000 slices) and paints colored particles that move randomly along the timelapse.

By default, the particles are contained within the image (i.e., they bump into the walls instead of crossing them).

Several parameters can be changed within the code, such as the size of the images and the number of slices, the number of particles, and the maximum amplitude of each step.

Note: The particles do not bump into each other (yet...).


#### `pearson.ijm`
Calculates the Pearson correlation coefficient between two images based on the following formula:

<img src="https://latex.codecogs.com/svg.latex?r_x_y=\frac{\sum_{i=1}^{n}(x_i-\bar&space;x)(y_i-\bar&space;y)}{\sqrt{\sum_{i=1}^{n}(x_i-\bar&space;x)^2}\sqrt{\sum_{i=1}^{n}(y_i-\bar&space;y)^2}}" title="r_x_y=\frac{\sum_{i=1}^{n}(x_i-\bar x)(y_i-\bar y)}{\sqrt{\sum_{i=1}^{n}(x_i-\bar x)^2}\sqrt{\sum_{i=1}^{n}(y_i-\bar y)^2}}" />


The images will be converted to a single-channel format (default is 32-bit but it can be changed to 8-bit or 16-bit; see macro comments).

Either rename your images to "1" and "2" before running the macro, or change the "1" and "2" strings within the code to the names of your images (see macro comments).


#### `stack2sequence.ijm`
Turns batches of image stacks into image sequences.


#### `getStarDistROIs.ijm`
Runs StarDist2D on each file of an image sequence. Read notes carefully.


#### `sequences2stacks.ijm`
Turns image sequences into image stacks.


#### `roiTracker.ijm`
Semi-automatic tracking of a single particle in each frame of an image stack.
