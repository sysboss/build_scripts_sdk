# Build script skeleton
This build script designed to run set of build steps which are discovered recursively inside project directory,
according it's version and/or modification.  
 
For example:

ExampleProject/
├── 7
│   ├── 7.2.1
│   │   └── some_fix
│   │       └── build_step2.sh
│   └── build_step1.sh
├── cleanup.sh
└── build_step1.sh

The build script will scan the path backwards starting from ExampleProject/7/7.2.1/some_fix and execute build steps related to desired version.
As a result, build_step1.sh will be taken from ExampleProject/7/ directory, build_step2.sh will be taken from ExampleProject/7/7.2.1/some_fix and the cleanup.sh will be executed from the default file located inside the project folder.
