#!/bin/sh
pushd ~/nix
home-manager switch -f ./user/zach/home.nix
popd
