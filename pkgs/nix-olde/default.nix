{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "nix-olde";
  commit = "7e8cd97be8f0006f16413b253e2c6faf96db66c1";
  version = "unstable-${finalAttrs.commit}";

  src = fetchFromGitHub {
    owner = "trofi";
    repo = "nix-olde";
    rev = "${finalAttrs.commit}";
    hash = "sha256-CJnqpZ5gAOsg+CIKtx01b05hL7J2/e1jEvoWjDcmNtM=";
  };

  cargoHash = "sha256-AhOrnZc1+OC0vF7zWkpEo4QtjXOwSlS21ptC1nuOziI=";
  doCheck = false;

  meta = {
    description = "Show details about outdated packages in your NixOS system.";
    homepage = "https://github.com/trofi/nix-olde";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [jasonxue1];
    mainProgram = "nix-olde";
    platforms = lib.platforms.all;
  };
})
