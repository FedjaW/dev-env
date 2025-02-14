#!/usr/bin/env bash

# get the absolute path of the directory where the script is located, 
# even if the script is executed from another directory
script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# first argument passed to the script
filter=$1

# start a new process and cd's into the dir
cd $script_dir

# find searches recursivly, here I prevent this by max and mindepth 1 
# -executable is preferred instead of -perm but not present on my mac...
# scripts=$(find ./runs -maxdepth 1 -mindepth 1 -executable -type f)
scripts=$(find ./runs -maxdepth 1 -mindepth 1 -type f -perm +100)

for script in $scripts; do
    # -q: quit, -v: inverse (not contains)
    if echo "$script" | grep -qv "$filter"; then
        echo "skipping '$script' due to filter '$filter'"
        continue
    fi
    ./$script
done