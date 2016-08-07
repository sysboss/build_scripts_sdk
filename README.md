# Build SDK
This script is a generic skeleton for build scripts with useful functions and libraries.
Designed to run set of build steps which are discovered recursively inside  the project directory.

Example of project directory structure:
```
ExampleProject/
├── 7
│   ├── 7.2.1
│   │   └── some_fix
│   │       └── 2_build_step.sh
│   └── 1_gether_artifacts.sh
│  
├── _build_steps.sh
├── 1_gether_artifacts.sh
├── 2_build_step.sh
├── 3_build_step.sh
├── cleanup.sh
├── getopts.sh
└── init_vars.sh
```

## Required input
Let's define important variables
```
export PRODUCT_NAME="ExampleProject"
export MAJOR_RELEASE="7"
export VERSION="7.2.1"
export CUSTOM_MODIFICATION="some_fix"
```

## What will happen?
The build script will scan the application folder (./ExampleProject) looking for _build_steps.sh file.  
This file defines all the build steps required to build the ExampleApp.  

In our case, it's:
 - 1_gether_artifacts.sh
 - 2_build_step.sh
 - 3_build_step.sh

Once we know our steps, the script will scan the application directory backwards starting from *ExampleProject/7/7.2.1/some_fix* and execute build steps related to the version you are trying to build.  

As a result, *1_gether_artifacts.sh* will be taken from *ExampleProject/7/* directory, *2_build_step.sh* will be taken from *ExampleProject/7/7.2.1/some_fix*.

And the *3_build_step.sh* and *cleanup.sh* will be executed from the default file located inside the default project directory, as long as there is no other alternative.  

## Things to notice
1. You can also override the *_build_steps.sh* file inside a version directory, for example.
2. cleanup.sh is running before program is finished and on HUP, TERM, INT signals.
3. *getopts.sh* will help you define your own args and variables. Based on: https://github.com/nk412/optparse 

## Installation
Clone the repo with *--recursive* flag!
```
git clone --recursive https://github.com/sysboss/build_scripts_sdk.git
```
