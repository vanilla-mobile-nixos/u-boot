{
  # TODO: pin nixpkgs
  nixpkgs ? (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable"),
  pkgs ? import nixpkgs {
    config.allowUnfree = true;
    overlays = [ ];
  },
  lib ? pkgs.lib,
}:
pkgs.lib.makeScope pkgs.newScope (self: {
  inherit pkgs lib;

  makeBootImage = self.callPackage ./make-boot-image.nix { };

  a2corelte = pkgs.pkgsCross.aarch64-multiplatform.callPackage ./a2corelte.nix { };
  a2corelte-boot-image = with self; makeBootImage a2corelte;

  dtbtool-exynos = self.callPackage ./dtbtool-exynos.nix { };
  devicetree = ./stub.dts;
})
