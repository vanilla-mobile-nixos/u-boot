{
  fetchFromGitLab,
  buildUBoot,
}:
buildUBoot {
  pname = "uboot-a2corelte";
  version = "0-unstable-2025-06-23";

  src = fetchFromGitLab {
    owner = "exynos7870-mainline";
    repo = "u-boot";
    rev = "34196d30646c3fd8975eb654927420f4590f6282";
    hash = "sha256-6vxn7V0ChTHhzSyuq3CGS4YmXcssXxood8G0gZoM6Gg=";
  };

  # No need for the raspberry pi specific patch
  patches = [ ];

  defconfig = "exynos-mobile_defconfig";

  filesToInstall = [
    "u-boot-nodtb.bin"
    "u-boot.dtb"
  ];

  extraMeta.platforms = [ "aarch64-linux" ];
}
