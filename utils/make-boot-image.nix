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
    gzip ${device}/u-boot.bin -c > u-boot.bin.gz
    cat ${device}/u-boot.dtb >> u-boot.bin.gz

    mkdir -p $out

    dtc -I dts -O dtb -o stub.dtb ${devicetree}
    dtbTool-exynos -o stub.dt.img stub.dtb

    mkbootimg  \
      --kernel u-boot.bin.gz \
      --dtb stub.dt.img \
      -o $out/u-boot.img
  ''
