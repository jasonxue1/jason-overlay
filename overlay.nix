final: prev: let
  inherit (final) lib;

  commonPackages = {
    nix-olde = final.callPackage ./pkgs/nix-olde {};
  };

  darwinPackages = lib.optionalAttrs final.stdenv.isDarwin {
    clash-verge-rev = final.callPackage ./pkgs/clash-verge-rev {};
  };

  packages = commonPackages // darwinPackages;
in {
  jason = packages;
}
