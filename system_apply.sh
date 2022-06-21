#!/bin/sh
pushd ~/nix
sudo nixos-rebulid switch -I nixos-config=./system/configuration.nix 
popd
