#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/dave/home.nix
popd
