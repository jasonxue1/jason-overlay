{
  description = "Jason's personal Nix overlay";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {nixpkgs, ...}: let
    systems = [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    overlay = import ./overlay.nix;
  in {
    overlays.default = overlay;

    packages = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [overlay];
      };
    in {
      clash-verge-rev = pkgs.jason.clash-verge-rev;
      karabiner-elements = pkgs.jason.karabiner-elements;
    });
  };
}
