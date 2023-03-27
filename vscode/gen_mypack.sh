#!/bin/sh
set -e

which zip || echo "Failure locating 'zip'"

for dir in mypack.*; do
    # Skip non-directories
    [ -d "$dir" ] || continue
    
    echo "== $dir =="
    cd "$dir"
    zip -r "../$dir-0.0.1.vsix" .
    cd ..
done
