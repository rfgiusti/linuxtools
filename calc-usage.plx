#!/usr/bin/perl

# calc-usage
# This is quite a simple script to calculate the space usage of every 
# subdirectory and report in a sorted, human-readable manner.
#
# Copyright 2014-15 "Rafael Giusti" (rfgiusti@gmail.com)
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at http://www.apache.org/licenses/LICENSE-2.0
#
# This software is on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. Use at your own risk.


use strict;

my @report = `du -sh */`;
my @sizes;
foreach my $item (@report) {
	$item =~ /([0-9.]+)([KMG\t])/;
	push @sizes, [$1, $item] if $2 eq "\t";
	push @sizes, [$1 * 1024, $item] if $2 eq "K";
	push @sizes, [$1 * 1024 * 1024, $item] if $2 eq "M";
	push @sizes, [$1 * 1024 * 1024 * 1024, $item] if $2 eq "G";
	push @sizes, [$1 * 1024 * 1024 * 1024 * 1024, $item] if $2 eq "T";
}
@sizes = sort { $b->[0] <=> $a->[0] } @sizes;
foreach my $item (@sizes) {
	print $item->[1];
}
