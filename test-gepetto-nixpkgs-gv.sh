#!/usr/bin/env bash

set -xeuo pipefail

nix build -L \
    .#python3Packages.crocoddyl \
    .#python3Packages.hpp-doc \
    .#python3Packages.tsid \
    .#gepetto-viewer
