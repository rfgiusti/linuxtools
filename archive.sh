#!/bin/bash

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
