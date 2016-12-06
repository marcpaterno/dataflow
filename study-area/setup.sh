#!/usr/bin/env bash
#Setup script for "uboonecode" with requested version and qualifiers (may default to current version)
setup studio v0_02_00
setup uboonecode v06_14_00 -q e10:prof
export BUILD_PATH=/Users/paterno/repos/dataflow/study-area/build
export SRC_PATH=/Users/paterno/repos/dataflow/study-area/src
LD_LIBRARY_PATH=/Users/paterno/repos/dataflow/study-area/build/lib:$LD_LIBRARY_PATH
