{
  description = "nim flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flake-nimble.url = "github:nix-community/flake-nimble";
  };
  
  outputs = { self, nixpkgs, flake-utils, flake-nimble }:
    flake-utils.lib.eachDefaultSystem (sys:
      let pkgs = nixpkgs.legacyPackages.${sys}; in
      rec {

        pkgsWithNimble = pkgs.appendOverlays [ flake-nimble.overlay ];
        
        packages = flake-utils.lib.flattenTree {
          nimlsp = pkgs.nimlsp;
          
          dummy = pkgs.nimPackages.buildNimPackage {
            pname = "dummy";
            version = "0.1.0";
            src = ./.;
            buildInputs = [ ];
          };
        };

        defaultPackage = packages.dummy;

        devShell = pkgs.mkShell {
          nativeBuildInputs = with packages; [ nimlsp ];
        };
      });
}
