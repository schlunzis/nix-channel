{ pkgs ? import <nixpkgs> { }, ... }:

{
  kurtama-client = pkgs.callPackage ./packages/kurtama-client { };
}
