{
  description = "MariaDB4j development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: nixpkgs.legacyPackages.${system};
    in
    {
      devShells = forAllSystems (system: {
        default = (pkgsFor system).mkShell {
          # JDK version must be the same here and in .java-version
          buildInputs = [ (pkgsFor system).jdk21_headless ];
        };
      });
    };
}
