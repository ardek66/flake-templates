{
  description = "elixir dummy";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (sys:
      let
        pkgs = nixpkgs.legacyPackages.${sys};
        beamPkgs = pkgs.beam.packagesWith pkgs.beam.interpreters.erlang;
      in {
        packages.dummy = beamPkgs.mixRelease {
          pname = "dummy";
          version = "0.1.0";
          src = ./.;
          buildInputs = [ beamPkgs.elixir_1_13 ];
        };

        defaultPackage = self.packages.${sys}.dummy;
      });
}
