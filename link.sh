#!/bin/sh

set -e

C="$(pwd)"

# Mount config file at OS level
o() { 
	sudo ln -vfs "$C/os/$1" "/etc/nixos/$1"
}

# Mount config file at home level
h() { 
	ln -vfs "$C/$1" "$HOME/.config/nixpkgs/$1" 
}

h aliases.nix
h config.hs
h home.nix

o configuration.nix
o hardware-configuration.nix
