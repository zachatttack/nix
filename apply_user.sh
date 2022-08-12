#!/bin/sh
pushd ~/nix-config
nix build .#homeManagerConfigurations.zach.activationPackage
./result/activate
popd
