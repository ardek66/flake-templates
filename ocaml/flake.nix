{
  description = "ocaml dummy";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (sys: 
      let pkgs = nixpkgs.legacyPackages.${sys};
      in {      
        packages.dummy = pkgs.ocamlPackages.buildDunePackage {
          pname = "dummy";
          version = "0.1.0";
          src = ./.;
          useDune2 = true;
          buildInputs = [ ];
        };
        
        defaultPackage = self.packages.${sys}.dummy;
      });
}
