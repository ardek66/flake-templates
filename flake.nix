{
  description = "bunch of templates because im lazy";

  outputs = { self }: {
    templates = {

      simple = {
        path = ./simple;
        description = "Simple flake";
      };
      
      ocaml = {
        path = ./ocaml;
        description = "OCaml flake (i hate dune)";
      };

      nim = {
        path = ./nim;
        description = "Nim flake";
      };

      haskell = {
        path = ./haskell;
        description = "Haskell flake";
      };
      
    };
  };
}
