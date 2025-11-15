{
  lib,
  stdenv,
  fetchurl,
  undmg,
}: let
  pname = "clash-verge-rev";
  version = "2.4.3";

  metaBase = {
    description = "Clash GUI based on tauri";
    homepage = "https://github.com/clash-verge-rev/clash-verge-rev";
    license = lib.licenses.gpl3Only;
    mainProgram = "clash-verge";
  };
  src-darwin = {
    aarch64-darwin = {
      src = fetchurl {
        url = "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${version}/Clash.Verge_${version}_aarch64.dmg";
        sha256 = "sha256-V78OnyVLsaNcHHr8iK9X2a3ZapUrFavQx9ycYrEojmY=";
      };
    };
    x86_64-darwin = {
      src = fetchurl {
        url = "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${version}/Clash.Verge_${version}_x64.dmg";
        sha256 = "sha256-CvzfQm+yGXDwLFdWfU4BBByQpuMZ3hOmomhPOFBPtPE=";
      };
    };
  };

  darwinSource =
    if stdenv.isDarwin
    then src-darwin.${stdenv.hostPlatform.system}
    else throw "clash-verge-rev is only available on macOS.";
  inherit (darwinSource) src;
in
  stdenv.mkDerivation {
    inherit
      pname
      version
      src
      ;
    meta =
      metaBase
      // {
        platforms = lib.platforms.darwin;
      };

    nativeBuildInputs = [undmg];
    sourceRoot = ".";
    installPhase = ''
      runHook preInstall
      mkdir -p $out/Applications
      cp -R "Clash Verge.app" "$out/Applications/Clash Verge.app"
      runHook postInstall
    '';
  }
