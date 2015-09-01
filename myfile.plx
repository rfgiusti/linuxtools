#!/usr/bin/perl

# my-file.plx
# If you run this script without specifying arguments, it will run on all
# files in the current directory.
#
# Copyright 2013-15 "Rafael Giusti" (rfgiusti@gmail.com)
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at http://www.apache.org/licenses/LICENSE-2.0
#
# This software is on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. Use at your own risk.

my $param;
if (@ARGV) {
	$param = '"' . join('" "', @ARGV) . '"';
}
else {
	$param = '"' . join('" "', <*>) . '"';
	die "No files in " . `pwd` if $param eq '""';
}

print `/usr/bin/file $param`;
