#!/usr/bin/env bash

# dotfiles directory
export DOTFILES
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Helpers
function sudo_permissions {
    groups | grep sudo > /dev/null 2>&1
    if [ $? == 0 ]; then
        return 0
    else
	return 1
    fi
}

function binary_exists {
    command -v $1 > /dev/null 2>&1
    if [ $? -ne 0 ]; then
	echo "|-- ERROR: $1 is not Installed!"
        return 1
    else
	return 0
    fi
}

function create_symlink {
	local source=$1
	local target=$2

	source=$(realpath $DOTFILES/$source)

	echo "|-- Creating Symlink: $source -> $target"

	ln -sfv "$source" "$target" > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		return 1
	else
		return 0
	fi
}

if [ ! have_permissions ]; then
    echo "ERROR - No sudo privelege"
fi

echo "########## INSTALLING ##########"
for installer in $DOTFILES/*/install
do
    echo "|# Installing: ${installer#$DOTFILES/install}"
    source $installer
done
