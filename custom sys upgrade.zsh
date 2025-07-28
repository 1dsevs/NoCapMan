#!/bin/zsh

function log()
{
	echo "$1" >> log.txt 
}

function extract()
{
	mkdir "cache/${f%.pkg.tar.zst}"
	tar -k -C "cache/${f%.pkg.tar.zst}" -x ".PKGINFO" -f "$1"
}

log "Program Start\n"

rm -r -f cache/* #clears the cache

mkdir cache/pkgs

for f in pkgs/*.pkg.tar.zst; do
	extract "$f" 
	echo "extracted ${f%.pkg.tar.zst}"
	log "extracted ${f%.pkg.tar.zst}"
;done
