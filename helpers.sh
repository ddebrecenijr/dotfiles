function sudo_permissions {
    groups | grep sudo > /dev/null 2>&1
    if [ $? == 0 ]; then
        return 0
    else
	return 1
    fi
}

function run_installer {
    INSTALLER=$1
    local tmp=${INSTALLER#"$DOTFILES/"}
    echo "=>    ${tmp%"/install"}"
}

function log_error {
    local MSG=$1
    ERRORS=$"${ERRORS[@]}" "- $MSG")
}

function report_errors {
    echo "  ==================================="
    echo "  Installation Complete: [${#ERRORS[@]} Errors]"
    echo "  ==================================="
    for msg in "${ERRORS[@]}"
    do
        echo $msg
    done
}

function binary_exists {
    command -v $1 > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        return 1
    else
	    return 0
    fi
}

function create_symlink {
	local SOURCE=$1
	local TARGET=$2

	SOURCE=$(realpath $DOTFILES/$SOURCE)

	echo "=>    Creating Symlink: $source -> $target"

	ln -sfv "$SOURCE" "$TARGET"
	if [ $? -ne 0 ]; then
        log_error "ERROR: Creating Symlink failed - $SOURCE -> $TARGET"
	fi
}
