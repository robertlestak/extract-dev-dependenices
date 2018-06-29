# extract-dev-dependencies

A simple script that will export language versions and global packages to a file which can then be shared to enable others to more easily replicate your development environment.

## Usage

````
./extract-dependencies.sh
````
This will attempt to create a `/tmp/ee_packages` directory as well as an `ee_packages.tar.gz` file in the same directory that the script is run. If this directory or file already exist, the script will prompt you to provide a new directory name.
