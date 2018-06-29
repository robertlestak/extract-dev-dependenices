#!/bin/bash

NODE_VER=ee_node_ver.txt
GO_VER=ee_go_ver.txt
NPM_PACK=ee_npm_packages.txt
BREW_PACK=ee_brew_packages.txt
YUM_PACK=ee_yum_packages.txt
APT_PACK=ee_apt_packages.txt
PACK_DIR=/tmp/ee_packages

function check_pack_dir () {
	if [ -d "$PACK_DIR" ] || [ -f "$PACK_DIR.tar.gz" ]; then
		echo $PACK_DIR or $PACK_DIR.tar.gz already exists!
		echo Please give a unique name for the output directory and file:
		read PACK_DIR
		check_pack_dir
	fi
}

check_pack_dir

mkdir $PACK_DIR

echo extracting dev dependencies...

if hash node 2>/dev/null; then
	echo node version
	node --version > $PACK_DIR/$NODE_VER
fi

if hash npm 2>/dev/null; then
	echo npm packages
	npm -g ls --depth=0 --parseable > $PACK_DIR/$NPM_PACK
fi

if hash go 2>/dev/null; then
	echo go version
	go version > $PACK_DIR/$GO_VER
fi

if hash brew 2>/dev/null; then
	echo brew packages
	brew leaves > $PACK_DIR/$BREW_PACK
fi

if hash apt 2>/dev/null; then
	echo apt packages
	apt list --installed > $PACK_DIR/$APT_PACK
fi

if hash yum 2>/dev/null; then
	echo yum packages
	yum list installed > $PACK_DIR/$YUM_PACK
fi

tar -zcf $PACK_DIR.tar.gz $(echo $PACK_DIR | sed 's,/tmp/,,')

rm -rf $PACK_DIR

echo dependencies exported to $PACK_DIR.tar.gz
