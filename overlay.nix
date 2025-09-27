final: _: let
  mkDarwinPackage = name: path:
    if final.stdenv.isDarwin
    then final.callPackage path {}
    else builtins.throw "${name} is only available on macOS.";
in {
  jason = {
    clash-verge-rev = mkDarwinPackage "clash-verge-rev" ./pkgs/clash-verge-rev;
  };

  clash-verge-rev = final.jason.clash-verge-rev;
}
