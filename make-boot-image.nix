{
  lib,
  runCommand,
  dtc,
  dtbtool-exynos,
  android-tools,

  devicetree,
}:
device:
runCommand "${device.pname}-boot-image"
  {
    nativeBuildInputs = [
      dtc
      dtbtool-exynos
      android-tools
    ];
  }
  ''
    gzip ${device}/u-boot-nodtb.bin -c > u-boot-nodtb.bin.gz
    cat ${device}/u-boot.dtb >> u-boot-nodtb.bin.gz

    mkdir -p $out

    dtc -I dts -O dtb -o stub.dtb ${devicetree}
    dtbTool-exynos -o stub.dt.img stub.dtb

    mkbootimg  \
      --kernel u-boot-nodtb.bin.gz \
      -o $out/u-boot.img
  ''
