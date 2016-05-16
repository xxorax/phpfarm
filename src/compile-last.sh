#!/bin/bash

basedir="`dirname "$0"`"

if [ "$1" == "" ]; then
    echo -e "\nYou must pass the PHP group version 5.5 / 5.6 / 7.0\n"
    exit 1
fi
minorVer=$1

prefix="$(echo "$minorVer" | sed 's/\./\\\./')"
version="$(curl -s "https://secure.php.net/releases/" | grep -o -m 1 '"'$prefix'\.[0-9]\+"' | awk -F'"' '{print $2}')"

if [ "$version" == "" ]; then
    echo -e "\nNo version found starting with $minorVer \n"
    exit 1
fi

echo ""

read -p "Last version from PHP releases website is $version - Install it? [y/n] " response

if [ "$response" != "y" ]; then
    echo -e "\nCanceled\n"
    exit 1
fi

echo ""

$basedir/compile.sh $version

instbasedir="$(readlink -f "$basedir/../inst")"

bins='php
php-cgi
php-config
phpize
pyrus
php-fpm
pecl'

for bin in $bins ; do
	if [ -f "$instbasedir/$bin-$version" ] ; then
		ls -fs "$instbasedir/$bin-$version" "$instbasedir/$bin-$minorVer"
		echo "$bin-$minorVer created"
	else
		echo "$bin-$version missing."
		rm -f "$instbasedir/$bin-$minorVer" && echo "$bin-$minorVer removed."
	fi
done

exit 0
