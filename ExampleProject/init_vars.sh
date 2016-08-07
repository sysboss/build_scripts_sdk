#!/bin/bash

# args tests
[[ "x${BUILD_WORSPACE}" = "x" ]] && die "Please define --workspace"
[[ "x${APP_PATH}" = "x" ]] && die "Please define --app-path"

# verify path is not a root
for i in "${BUILD_WORSPACE}" "${APP_PATH}"; do
    if [ $i == '/' ]; then
        echo "WARNING! Path cannot be equal to '/'"
        exit 2
    fi
done
