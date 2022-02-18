#!/bin/sh

set -e

C="$(pwd)"

athome() { 
  ln -vfs "$C/$1" "$HOME/.config/nixpkgs/$1"
}

athome aliases.nix
athome config.hs
athome home.nix
