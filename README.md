# fiji_macros

A compilation of Fiji macros developed during my PhD.

The code in each macro contains comments to help the user modulate different parameters.

## How to use the macros

1. Download the file.
2. Open Fiji.
3. Go to "Plugins -> Macros -> Run" to run the macros or "Plugins -> Macros -> Edit" to edit them.
4. Select the file and click "Open".

## List of macros (and what they do):

#### `brownian_contained.ijm`
Creates an image stack (default is 16-bit, 200x200, 1000 slices) and paints colored particles that move randomly along the timelapse.

By default, the particles are contained within the image (i.e., they bump into the walls instead of crossing them).

Several parameters can be changed within the code, such as the size of the images and the number of slices, the number of particles, and the maximum amplitude of each step.


#### `pearson.ijm`
Calculates the Pearson correlation coefficient between two images.

The images will be converted to a single-channel format (default is "32-bit" but this can be changed to 8-bit or 16-bit).

Note: Either rename your images to "1" and "2" before running the macro, or change the "1" and "2" names within the code (see macro comments).
