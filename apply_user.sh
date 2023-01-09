#!/bin/sh
pushd ~/nix-config
nix build .#homeConfigurations.zach.activationPackage
./result/activate
popd
