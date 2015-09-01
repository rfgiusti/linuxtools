#!/bin/bash

# texclean.sh
# Removes temporary LaTeX files from a directory.
#
# Copyright 2012-15 "Rafael Giusti" (rfgiusti@gmail.com)
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at http://www.apache.org/licenses/LICENSE-2.0
#
# This software is on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. Use at your own risk.

# If this is not a LaTeX directory, just give it up
grep -F '\documentclass' *.tex &> /dev/null
ret=$?
if [[ $ret != 0 ]]; then
	echo "There doesn't seem to be any LaTeX project to clean up here."
	exit
fi

# Is threre a main project to clean?
project=""
pdf_name=""
has_temp=0
for i in *.{bbl,blg,log,toc,pdf}; do
	has_temp=1
	name=`echo -n "$i" | sed 's/\....$//'`
	grep -F '\documentclass' "$name.tex" &> /dev/null
	ret=$?
	if [[ $ret == 0 ]]; then
		if [[ "$project" == "" || "$project" == "$name" ]]; then
			project="$name"
			pdf_name="$name.pdf"
		else
			pdf_name="CONFLICT"
		fi
	fi
done

# If there are temporary files, but no project associated, well, I'm confused
if [[ $has_temp == 1 && "$project" == "" ]]; then
	echo "There seems to be temporary files here, but no project associated with them."
	exit
fi

# Should I remove the pdf as well?
remove_pdf=0
for arg in "$@"; do
	if [[ "$arg" == "pdf" || $arg == "all" ]]; then
		remove_pdf=1
	fi
done

# Clean it
rm -v -f *~ *.aux *.backup *.dvi *.lof *.log *.lot *.out *.toc *.bbl *.blg *.brf *.nav *.snm
if [[ $remove_pdf == 1 ]]; then
	if [[ "$pdf_name" == "CONFLICT" ]]; then
		echo "There seems to be more than one project PDF here. I won't delete any of them."
		exit
	else
		rm -f -v $pdf_name
	fi
fi
