#!/bin/zsh

function log()
{
	echo "$1" >> log.txt 
}

function extract()
{
	unprocessed_dir=$1
	
	length=${#unprocessed_dir}
	
	dir=${unprocessed_dir[6,length]}
	
	mkdir "cache/${dir%.pkg.tar.zst}"
	tar -k -C "cache/${dir%.pkg.tar.zst}" -x ".PKGINFO" -f "$1"

	cat "cache/${dir%.pkg.tar.zst}/.PKGINFO" | grep -w "depend" >> deps/depend.txt
	cat "cache/${dir%.pkg.tar.zst}/.PKGINFO" | grep -w "makedepend" >> deps/makedepend.txt
	cat "cache/${dir%.pkg.tar.zst}/.PKGINFO" | grep -w "optdepend" >> deps/optdepend.txt
	cat "cache/${dir%.pkg.tar.zst}/.PKGINFO" | grep -w "checkdepend" >> deps/checkdepend.txt
}

log "Extractor Start\n"

rm -r -f cache/* #clears the cache

mkdir deps

for f in pkgs/*.pkg.tar.zst; do
	extract "$f" 
	echo "extracted ${f%.pkg.tar.zst}"
	log "extracted ${f%.pkg.tar.zst}"
;done

