{
  self ? import ./utils/import-flake.nix { src = ./.; },
  inputs ? self.inputs,
  system ? builtins.currentSystem,
  pkgs ? import inputs.nixpkgs {
    config = { };
    overlays = [ ];
    inherit system;
  },
  lib ? import "${inputs.nixpkgs}/lib",
}:
pkgs.lib.makeScope pkgs.newScope (self': {
  inherit self pkgs lib;

  makeBootImage = self'.callPackage ./utils/make-boot-image.nix { };

  a2corelte = pkgs.pkgsCross.aarch64-multiplatform.callPackage ./devices/a2corelte.nix { };
  a2corelte-boot-image = with self'; makeBootImage a2corelte;

  dtbtool-exynos = self'.callPackage ./utils/dtbtool-exynos.nix { };
})
