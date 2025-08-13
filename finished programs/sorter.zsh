#!/bin/zsh

DestinationDir="SortedDeps"

function log()
{
    echo "$1" >> log.txt 
}

function sortdep()
{
    Filename="${1%.txt}_sorted.txt"
    Filename=${Filename:4}
    
    mkdir "cache/sort"
    sort -o "cache/sort/$Filename" "$1" # Alphabetically sort the dependencies

    awk '!seen[$0]++' "cache/sort/$Filename" > "$DestinationDir/$Filename" # Remove repeating dependencies
}

log "Sorter Start\n"

rm -r -f cache/*/* #clears the cache

mkdir "$DestinationDir"

for f in deps/*; do
        sortdep "$f" 
        echo "sorted $f"
        log "sorted $f"
;done
