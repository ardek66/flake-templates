{
  description = "ocaml dummy";

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {      
      packages.x86_64-linux.dummy = pkgs.ocamlPackages.buildDunePackage {
        pname = "dummy";
        version = "0.1.0";
        src = ./.;
        useDune2 = true;
        buildInputs = [ ];
      };
      
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.dummy;
    };
}
