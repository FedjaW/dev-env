#!/usr/bin/env bash

# copied the try run thingy from run.sh because we can
# and don't want to build a bash-sytem-abstraction-manager-library-hander
script_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

dry="0"

while [[ $# > 0 ]]; do
    if [[ $1 == "--dry" ]] ; then
        dry="1"
    fi
    shift
done

log() {
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

    "$@"
}

cd $script_dir

log "------------ dev-env ------------"

copy_file () {
    from=$1
    to=$2

    # what basename and dirname do:
    # basename /foo/bar/baz -> baz
    # dirname /foo/bar/baz -> /foo/bar
    name=$(basename $from)

    execute rm $to/$name
    execute cp $from $to/$name
}

copy_dir () {
    from=$1
    to=$2

    # pushes a dir onto the location stack
    # so we can pop it of later
    pushd $from > /dev/null # redirect into the trash
    # now we are in the from dir
    dirs=$(find . -maxdepth 1 -mindepth 1 -type d) # find all dirs
    for dir in $dirs; do
        execute rm -rf $to/$dir # remove current stuff in the destination folder 
        execute cp -r $dir $to/$dir # copy new stuff into it
    done

    popd > /dev/null
}

copy_dir .config $HOME/.config
copy_dir .local $HOME/.local
# copy_file .test $HOME

