{ pkgs ? import <nixpkgs> { } }: rec {
  # Packages with an actual source
  shellcolord = pkgs.callPackage ./shellcolord { };
}
