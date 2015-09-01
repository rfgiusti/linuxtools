#!/bin/bash

# move-window-to-screen
# This script moves the current focused window to the second screen, assuming
# you currently have two screens and they are placed side-by-side. It is best
# used if you map some short cut in your Desktop Manager, like META+Z.

# Copyright 2014-15 "Rafael Giusti" (rfgiusti@gmail.com)
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at http://www.apache.org/licenses/LICENSE-2.0
#
# This software is on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. Use at your own risk.

# FIXME: check for xdotool, xwininfo, and xprop before going

# FIXME: hard-coded screen info
SCREEN_WIDTH=1200
X_FIX=-1
Y_FIX=-22

# Get window information
window=`xdotool getwindowfocus`
xpos=`xwininfo -id $window | grep -F "Absolute upper-left X" | sed "s/.*:\s*//"`
ypos=`xwininfo -id $window | grep -F "Absolute upper-left Y" | sed "s/.*:\s*//"`

# Check what side of the screen we are in
if [[ $xpos -lt $SCREEN_WIDTH ]]; then
	xpos=$(( $xpos + $SCREEN_WIDTH ))
else
	xpos=$(( $xpos - $SCREEN_WIDTH ))
fi

# Workaround fixes
xpos=$(( $xpos + $X_FIX ))
ypos=$(( $ypos + $Y_FIX ))

# Perform the job
maximized=`xprop -id $window _NET_WM_STATE | grep MAXIMIZED`
[[ "$maximized" != "" ]] && wmctrl -ir $window -b remove,maximized_vert,maximized_horz
xdotool getwindowfocus windowmove -- $xpos $ypos 2>&1
[[ "$maximized" != "" ]] && wmctrl -ir $window -b add,maximized_vert,maximized_horz
