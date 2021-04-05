# fiji_macros

A repository of Fiji macros developed during my PhD.

## List of macros (and what they do):

### brownian_contained.ijm
Creates an image stack (default is 16-bit, 200x200, 1000 slices) and paints colored particles that move randomly along the timelapse.

By default, the particles are contained within the image (i.e., they bump into the walls instead of crossing them).

Several parameters can be changed within the code, such as the size of the images and the number of slices, the number of particles, and the maximum amplitude of each step.

The code contains comments to help the user change these parameters.
