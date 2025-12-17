{
  description = "Hades Saves Extractor";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    hse-src = {
      type = "git";
      # url = "github:coldelectrons/HadesSavesExtractor";
      url = "https://github.com/coldelectrons/HadesSavesExtractor";
      flake = false;
      submodules = true;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    hse-src,
  }:
    flake-utils.lib.eachDefaultSystem ( system:
    let
        pkgs = import nixpkgs { inherit system; };
        # lib = pkgs.lib;
    in {
      packages = rec {
        hades-saves-extractor = pkgs.callPackage ./default.nix { src = hse-src; };
        default = hades-saves-extractor;
      };
      # devShells.default = packages.default.shell;
      formatter = pkgs.alejandra;
    });
}
