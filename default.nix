{
  # TODO: pin nixpkgs
  nixpkgs ? (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable"),
  pkgs ? import nixpkgs {
    config = { };
    overlays = [ ];
  },
  lib ? pkgs.lib,
}:
pkgs.lib.makeScope pkgs.newScope (self: {
  inherit pkgs lib;

  makeBootImage = self.callPackage ./utils/make-boot-image.nix { };

  a2corelte = pkgs.pkgsCross.aarch64-multiplatform.callPackage ./devices/a2corelte.nix { };
  a2corelte-boot-image = with self; makeBootImage a2corelte;

  dtbtool-exynos = self.callPackage ./utils/dtbtool-exynos.nix { };
})
