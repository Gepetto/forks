#!/usr/bin/env bash
# This file is generated by fork-manager. Do not edit by hand !
set -xeuo pipefail

# https://stackoverflow.com/a/246128/1368502
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

pushd "$SCRIPT_DIR"

git submodule update --init


# gepetto-nixpkgs-master {{

if git submodule status | grep -q " gepetto-nixpkgs-master "
then
    git submodule set-branch --branch master gepetto-nixpkgs-master
    git submodule set-url gepetto-nixpkgs-master git@github.com:gepetto/nixpkgs
else
    git submodule add -b master git@github.com:gepetto/nixpkgs gepetto-nixpkgs-master
    git add .gitmodules
    git commit -m "add submodule for gepetto-nixpkgs-master"
fi

pushd gepetto-nixpkgs-master
git checkout master


for remote in git@github.com:NixOS/nixpkgs git@github.com:gepetto/nixpkgs git@github.com:nim65s/nixpkgs
do
    name=$(echo "$remote" | sed 's=https://==;s=git@==;s=:=/=g')
    if git remote | grep -q "^$name$"
    then
        git remote set-url "$name" "$remote"
    else
        git remote add "$name" "$remote"
    fi
done

git fetch --all --prune
git reset --hard github.com/NixOS/nixpkgs/master

{
    echo "# fork-manager"
    echo

    echo "This branch is managed from https://github.com/gepetto/forks"



    echo "It is based on git@github.com:NixOS/nixpkgs master"
    echo -n "  which is on: "
    git log --no-color --format=reference -1

    echo
    echo "It include:"


# gepetto-viewer: init at 5.1.0 {{{
    git merge --no-edit "github.com/nim65s/nixpkgs/gepetto-viewer" >&2
    echo "- gepetto-viewer: init at 5.1.0"
    echo -n "  in: "
    git log --no-color --format=reference -1
    echo -n "  which is on: "
    git log --no-color --format=reference -1 "github.com/nim65s/nixpkgs/gepetto-viewer"
# }}}

# hpp-fcl: add missing dependency {{{
    git merge --no-edit "github.com/nim65s/nixpkgs/hpp-fcl" >&2
    echo "- hpp-fcl: add missing dependency"
    echo -n "  in: "
    git log --no-color --format=reference -1
    echo -n "  which is on: "
    git log --no-color --format=reference -1 "github.com/nim65s/nixpkgs/hpp-fcl"
# }}}

# tsid: init at 1.7.1 {{{
    git merge --no-edit "github.com/nim65s/nixpkgs/tsid" >&2
    echo "- tsid: init at 1.7.1"
    echo -n "  in: "
    git log --no-color --format=reference -1
    echo -n "  which is on: "
    git log --no-color --format=reference -1 "github.com/nim65s/nixpkgs/tsid"
# }}}

# pinocchio: 3.1.0 -> 3.2.0 {{{
    git merge --no-edit "github.com/nim65s/nixpkgs/pinocchio" >&2
    echo "- pinocchio: 3.1.0 -> 3.2.0"
    echo -n "  in: "
    git log --no-color --format=reference -1
    echo -n "  which is on: "
    git log --no-color --format=reference -1 "github.com/nim65s/nixpkgs/pinocchio"
# }}}

# hpp {{{
    git merge --no-edit "github.com/gepetto/nixpkgs/hpp" >&2
    echo "- hpp"
    echo -n "  in: "
    git log --no-color --format=reference -1
    echo -n "  which is on: "
    git log --no-color --format=reference -1 "github.com/gepetto/nixpkgs/hpp"
# }}}

# osg-dae {{{
    git merge --no-edit "github.com/gepetto/nixpkgs/osg-dae" >&2
    echo "- osg-dae"
    echo -n "  in: "
    git log --no-color --format=reference -1
    echo -n "  which is on: "
    git log --no-color --format=reference -1 "github.com/gepetto/nixpkgs/osg-dae"
# }}}


    echo
    echo "---"
    echo

    test -f README.md && cat README.md
} > "../.gepetto-nixpkgs-master.log"

mv "../.gepetto-nixpkgs-master.log" README.md
git add README.md
git commit -m "document fork manager"

[[ -x "../test-gepetto-nixpkgs-master.sh" ]] && "../test-gepetto-nixpkgs-master.sh"

[[ "$#" -eq 1 && "$1" == "push" ]] && git push -f github.com/gepetto/nixpkgs master
popd

git add gepetto-nixpkgs-master
git commit -m "updated gepetto-nixpkgs-master"

# }}


popd
