{ pkgs ? import <nixpkgs> {} }:

(import ./stack.nix {inherit pkgs;}).iridium
