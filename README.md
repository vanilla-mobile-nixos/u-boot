> [!WARNING]
> The u-boot image builds, but the functionality has not been tested.
> Use at your own risk.

### Requirements

- [nix](https://nixos.org/)

### Build

```
nix-build -A a2corelte-boot-image
```

You will find the image file under `./result`:

```
$ ls ./result/
 u-boot.img
```

### Resources

- [Samsung Exynos 7870 Mainline / U-Boot](https://gitlab.com/exynos7870-mainline/u-boot/-/blob/fioricet/exynos7870-generic-bringup/doc/board/samsung/exynos-mobile.rst)
