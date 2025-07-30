#!/bin/zsh

function log()
{
	echo "$1" >> log.txt 
}

function sort()
{
	cat $1 | sort -o "${1%.txt}_sorted.txt"
}

log "Program Start\n"

rm -r -f cache/* #clears the cache

mkdir deps

for f in deps/*; do
	sort "$f" 
	echo "sorted ${f%.pkg.tar.zst}"
	log "sorted ${f%.pkg.tar.zst}"
;done

