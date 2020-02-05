#!/usr/bin/env bash

# dotfiles directory
export DOTFILES
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# update repo
[ -d "$DOTFILES/.git" ] && git --work-tree="$DOTFILES" --git-dir="$DOTFILES/.git" pull origin feature/work-setup

# Helpers
source $DOTFILES/helpers.sh

if [ ! have_permissions ]; then
    echo "ERROR - No sudo privelege"
fi

if [ "$#" -eq 0 ]
then
    echo "########## INSTALLING ##########"
    for INSTALLER in $DOTFILES/*/install
    do
        run_installer $INSTALLER
        source $INSTALLER
    done
else
    for prog in $@
    do
        INSTALLER=$DOTFILES/$prog/install
        if [ -e $INSTALLER ]
        then
            run_installer $INSTALLER
            source $INSTALLER
        else
            log_error "Invalid Installer specified: $prog"
        fi
    done
fi

report_errors
