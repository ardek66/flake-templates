{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (sys:
      let pkgs = nixpkgs.legacyPackages.${sys};
      in {
        packages.dummy = pkgs.hello;
        defaultPackage = self.packages.${sys}.dummy;
      });
}
