#!/bin/bash

# Define options
optparse.define short=w long=workspace desc="Path to build workspace" variable=BUILD_WORSPACE
optparse.define short=a long=app-path desc="Path or URL to the application tar" variable=APP_PATH

# Advanced options
optparse.define short=x long=no-cleanup desc="Skip cleanup" variable=SKIP_CLEANUP value=true default=false
optparse.define short=s long=sudo desc="Execute all commands as root" variable=USE_SUDO value=true default=false
optparse.define short=l long=lock desc="Use lockfile to prevent parallel execution" variable=USE_LOCK value=true default=false

# Show error if no args
(( $# == 0 )) && echo "No arguments specified. Use --help for more information" && exit 127
