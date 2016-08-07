#!/bin/bash

echo "STEP 1: 1_gether_artifacts.sh from version 7 is taking over the default one."

# this script will be executed, as long as no other 1_gether_artifacts.sh
# found inside sub version or modification folder tree

# STEP 1
# This will bring all required artifacts

echo "STEP #1"
echo "Getting required artifacts"

# create artifacts dir
$SUDO mkdir -p "${RUN_DIR}/${BUILD_WORSPACE}/artifacts"

# get the application
APP_FILE="${BUILD_WORSPACE}/artifacts/application.tar.gz"
get_file_from "${APP_PATH}" "${APP_FILE}" "ExampleApplication"
