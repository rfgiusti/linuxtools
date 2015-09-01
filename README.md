Linux Tools
-----------

Some of the tools I have been using routinelly might be shared here.


License
-------

As usual for my projects, please consider the "Apache License version 2".

In essence please, feel free to copy, modify, and share your modifications under
"Apache License 2". If you make any substantial modifications, please state so.


Tools in here
-------------

1. `archive`: attempts to collect data under a directory into a `tar.gz` file
	with the same base name as the directory, then remove the directory;
1. `calc-usage`: calculates the disk used by each subdirectory and reports them
	in a sorted, human-readable form;
1. `move-window-to-screen`: if you are using two screens, move the currently
	focused window between the left and the right screen. Requires
	`xdotools`, `xwininfo`, and `xprop`. Requires that the resolution of the
	screen to the left be specified manually (easiy fixed);
1. `myfile`: if you call `file` withtout arguments, this script will call all
	files in the current directory as arguments for you;
1. `texclean`: removes LaTeX temporary files from the current directory, but
	only if there is a single `.tex` file with a `\documentclass`.
