{
  description = "A flake to build the haskell playground";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixfmt-rfc-style
            # basic dependencies
            zlib
            # haskell
            cabal-install
            haskell.compiler.ghc910
            # system dependencies
            certbot
            bubblewrap
          ];
        };
        devShells.ghcup = pkgs.mkShell {
          buildInputs = with pkgs; [
            # ghcup
            zlib
            pkg-config
            gcc
            curl
            gmp
            gnumake
            ncurses
            xz
          ];
        };
      }
    ));
}

