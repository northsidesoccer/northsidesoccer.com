{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
      ];
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          hugo = pkgs.callPackage ./hugo.nix {};
        in {
          packages.default = pkgs.hello;
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = [
              hugo
              pkgs.ncftp
            ];
          };
        };
      };
}
