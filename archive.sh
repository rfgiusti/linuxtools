#!/bin/bash

# archive
# This will attempt to archive the contents of a directory into a .tar.gz file
# with the same base name as the directory, and then remove the directory
# files.
#
# Copyright 2015 "Rafael Giusti" (rfgiusti@gmail.com)
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at http://www.apache.org/licenses/LICENSE-2.0
#
# This software is on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. Use at your own risk.

if [[ "$1" == "" ]]; then
	echo "Usage $0  <dir1> [<dir2> ...]"
	exit 1
fi

for i in "$@"; do
	dirname="$i"
	if [[ ! -d "$dirname" ]]; then
		echo "$dirname: not a directory"
		continue
	fi

	tgzname=$( echo -n "$dirname" | sed 's!/\?$!.tgz!' )
	if [[ -e "$tgzname" ]]; then
		echo "$tgzname: target exists and will not be overwritten"
		continue
	fi

	if echo -n "$tgzname" | grep /; then
		echo "$tgzname: .tgz name contains a slash"
		continue
	fi

	tar czpf "$tgzname" "$dirname"
	st=$?
	if [[ $st -ne 0 ]]; then
		echo "$dirname: tar exit status non-zero: $st"
		continue
	fi

	rm -r "$dirname"
	st=$?
	if [[ $st -ne 0 ]]; then
		echo "$dirname: archive created ($tgzname), but source not fully removed (may have been partially removed, though): rm returned $st"
		continue
	fi

	echo "$dirname: archived"
done
