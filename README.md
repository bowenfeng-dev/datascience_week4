This R script exposes a function named run.analysis().  It does not require passing in any arguments, but you need to set the working directory to the data root folder so that the files can be accessed.

The script uses readr library to read the files into memory. The built in R read.* functions consumed way too many memory in my computer (Win10 + 8G momery) so it failed eventually when load the X_train.txt file.  After switched to read_table() function provided by readr library, the memory footage become neglectable.

After define some helper functions inside the run.analysis() function, the actual data processing was done by using the chaining operator provided by dplyr library. This effectively eliminates all the unnecessary intermediate variables and make the process much cleaner.

Each step is well documented in the source code.
