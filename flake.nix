{
  description = "Fork of Volantres Cursors with the Material colour palette.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, pre-commit-hooks, ... }:
    let
      supportedSystems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
      perSystem = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: import nixpkgs { inherit system; };

      overlay = import ./nix/overlay.nix;

      pre-commit-check-for = system: pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          nixpkgs-fmt.enable = true;
        };
      };

      shellFor = system:
        let
          pkgs = pkgsFor system;
          pre-commit-check = pre-commit-check-for system;
        in
        pkgs.mkShell {
          name = "volantres-cursors-material devShell";
          inherit (pre-commit-check) shellHook;
          buildInputs = with pkgs; [
            zlib
            inkscape
            xorg.xcursorgen
          ];
        };
    in
    {
      overlays = {
        inherit overlay;
        default = overlay;
      };

      devShells = perSystem (system: rec {
        default = devShell;
        devShell = shellFor system;
      });

      packages = perSystem (system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ overlay ]; };
        in
        {
          default = pkgs.volantres-cursors-material;
        });

      checks = perSystem (system:
        let
          checkPkgs = import nixpkgs { inherit system; overlays = [ overlay ]; };
        in
        {
          formatting = pre-commit-check-for system;
          inherit (checkPkgs) volantres-cursors-material;
        });
    };
}
