{
  lib,
  runCommand,
  dtc,
  dtbtool-exynos,
  android-tools,
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

    if [ ${toString (device ? deviceTree)} ]; then
      dtc -I dts -O dtb -o stub.dtb ${device.deviceTree}
      dtbTool-exynos -o stub.dt.img stub.dtb
    fi

    mkbootimg  \
      --kernel u-boot.bin.gz \
      ${lib.optionalString (device ? deviceTree) "--dtb stub.dt.img"} \
      -o $out/u-boot.img
  ''
