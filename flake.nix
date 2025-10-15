{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, ... }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        default = import ./default.nix { inherit self inputs system; };
      in
      {
        packages = {
          inherit (default)
            a2corelte
            a2corelte-boot-image
            ;
        };
      }
    );
}
