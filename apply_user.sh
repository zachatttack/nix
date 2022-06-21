#!/bin/sh
pushd ~/nix
nix build .#homeManagerConfigurations.zach.activationPackage
./result/activate
popd
