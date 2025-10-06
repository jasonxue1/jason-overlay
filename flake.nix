{
  description = "Jason's personal Nix overlay";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {nixpkgs, ...}: let
    inherit (nixpkgs) lib;
    overlay = import ./overlay.nix;
    perSystem = system: let
      result = builtins.tryEval (let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [overlay];
          config.allowUnfree = true;
        };
      in
        pkgs.jason);
    in
      if result.success
      then result.value
      else {};
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in {
    overlays.default = overlay;

    packages = lib.genAttrs systems perSystem;
  };
}
