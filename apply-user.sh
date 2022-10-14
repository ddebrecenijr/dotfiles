#!/bin/sh
pushd ~/.dotfiles
nix build .#homeManagerConfigurations.dave.activationPackage
./result/activate
popd
