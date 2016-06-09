#!/bin/bash

# backlink.sh
# Search for symbolic links that point to a file or directory.
#
# Copyright 2016 "Rafael Giusti" (rfgiusti@gmail.com)
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at http://www.apache.org/licenses/LICENSE-2.0
#
# This software is on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. Use at your own risk.

tgt=$1

if [ "$tgt" == "" ]; then
	echo "Usage: $0 file"
	exit 1;
fi

if [ ! -f "$tgt" -a ! -d "$tgt" ]; then
	echo "Can't find symbolic links to non-existent target '$tgt'"
	exit 1;
fi
if [ -L "$tgt" ]; then
	echo "Warning: target '$tgt' is a symbolic link. Result may be unclear"
fi

find -type l -exec bash -c "test '{}' -ef '$tgt' && echo '{}'" \;
