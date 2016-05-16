#!/bin/bash

dir="$(dirname $0)/../inst/"

bins='php
php-cgi
php-config
phpize
pyrus
php-fpm
pecl'

# take only the first line for find exisitng versions
bin="${bins%%$'\n'*}"

versions="$(ls -1 "$dir" | grep -E "$bin"'-[0-9]+\.[0-9]+\.*' | sed -r 's/^'$bin'-//' | sort -V)"

minorVersions="$(echo "$versions" | sed -r 's/^([0-9]+\.[0-9]+)\..+/\1/')"

echo "Found versions:"
echo "$minorVersions"

lastVersions=""
for version in $minorVersions; do
	lastVersion=$(echo "$versions" | grep -E "^${version//\./\\.}" | sort -V | head -n 1)
	if [ -z $lastVersion ] ; then
		continue
	fi

	lastVersions="$lastVersions $lastVersion"
done

for version in $lastVersions ; do
	minorVersion="$(echo "$version" | sed -r 's/^([0-9]+\.[0-9]+)\..+/\1/')"

	for bin in $bins ; do
		minorVersionLink="$dir$bin-$minorVersion"
		[ -L "$minorVersionLink" ] && rm "$minorVersionLink"

		versionBin="$dir$bin-$version"

		if [ -e "$versionBin" ] ; then
			ln -s "$versionBin" "$minorVersionLink"
		else
			echo "Cannot find file $versionBin" 1>&2
		fi

	done
done
