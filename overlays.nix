{ inputs, ...}: {
  nixpkgs.overlays = [
    inputs.niri.overlays.niri
    inputs.claude-code.overlays.default
  ];
}
