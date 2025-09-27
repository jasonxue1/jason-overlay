# jason-overlay

Personal Nix overlay for two macOS-only desktop tools (darwin systems only):

- `clash-verge-rev` – the upstream macOS release from the official DMG.
- `karabiner-elements` – version 14.13.0, the last Sonoma-compatible build.

Both packages live under `pkgs.jason.*`, e.g. `pkgs.jason.clash-verge-rev` or `pkgs.jason.karabiner-elements`.

## Using without flakes

Add this repository to your `NIX_PATH` and extend the overlays list:

```nix
let
  jasonOverlay = import /path/to/jason-overlay;
  pkgs = import <nixpkgs> {
    overlays = [jasonOverlay];
  };
in {
  environment.systemPackages = [pkgs.jason.clash-verge-rev pkgs.jason.karabiner-elements];
}
```

## Using with flakes

Reference the overlay as an input and enable it through the standard overlay mechanism:

```nix
{
  inputs.jason-overlay.url = "github:jasonxue1/jason-overlay";

  outputs = {
    self,
    nixpkgs,
    jason-overlay,
    ...
  }: {
    nixosConfigurations.example = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({
          config,
          pkgs,
          ...
        }: {
          nixpkgs.overlays = [jason-overlay.overlays.default];
          environment.systemPackages = [pkgs.jason.clash-verge-rev pkgs.jason.karabiner-elements];
        })
      ];
    };
  };
}
```

Pre-built packages are also exposed through flake outputs under `packages.${system}`.
