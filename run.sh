#!/usr/bin/env bash

# get the absolute path of the directory where the script is located, 
# even if the script is executed from another directory
script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

# arguments passed to the script
filter=""
dry="0"

# $# is the number of arguments
while [[ $# > 0 ]]; do
    if [[ $1 == "--dry" ]] ; then
        dry="1"
    else 
        filter=$1
    fi
    # remove the first argument from the arguments list
    # so to say: pop of every argmument as the while loop loops
    shift
done

log() {
    # $@ means print out everything that was passed
    # as an argument to the function log
    if [[ $dry == "1" ]] ; then
        echo "[DRY_RUN]: $@"
    else 
        echo "$@"
    fi
}

execute() {
    log "execute $@"
    if [[ $dry == "1" ]] ; then
        return
    fi

    # execute everything
    "$@"
}

log "$script_dir -- $filter"

# start a new process and cd's into the dir
cd $script_dir

# find searches recursivly, here I prevent this by max and mindepth 1 
# -executable is preferred instead of -perm but not present on my mac...
# scripts=$(find ./runs -maxdepth 1 -mindepth 1 -executable -type f)
scripts=$(find ./runs -maxdepth 1 -mindepth 1 -type f -perm +100)

for script in $scripts; do
    # -q: quit, -v: inverse (not contains)
    if echo "$script" | grep -qv "$filter"; then
        log "skipping '$script' due to filter '$filter'"
        continue
    fi
    execute ./$script
done