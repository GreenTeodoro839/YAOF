#!/bin/bash

latest_release="$(curl -s https://github.com/openwrt/openwrt/tags | grep -Eo "v[0-9\.]+\-*r*c*[0-9]*.tar.gz" | sed -n '/[2-9][0-9]/p' | sed -n 1p | sed 's/.tar.gz//g')"
git clone --single-branch -b ${latest_release} https://github.com/openwrt/openwrt openwrt_release
git clone --single-branch -b openwrt-22.03 https://github.com/openwrt/openwrt openwrt
cd openwrt
# rockchip: add drm and lima gpu driver
wget https://github.com/immortalwrt/immortalwrt/commit/c10101fc0cf186196a354a91a75bf2856630dd68.patch
wget https://github.com/coolsnowwolf/lede/raw/757e42d70727fe6b937bb31794a9ad4f5ce98081/target/linux/rockchip/config-default -NP target/linux/rockchip/
wget https://github.com/coolsnowwolf/lede/commit/f341ef96fe4b509a728ba1281281da96bac23673.patch
git apply f341ef96fe4b509a728ba1281281da96bac23673.patch
git apply c10101fc0cf186196a354a91a75bf2856630dd68.patch
rm f341ef96fe4b509a728ba1281281da96bac23673.patch
rm c10101fc0cf186196a354a91a75bf2856630dd68.patch
cd ..
rm -f ./openwrt/include/version.mk
rm -f ./openwrt/include/kernel.mk
rm -f ./openwrt/include/kernel-5.10
rm -f ./openwrt/include/kernel-version.mk
rm -f ./openwrt/include/toolchain-build.mk
rm -f ./openwrt/include/kernel-defaults.mk
rm -f ./openwrt/package/base-files/image-config.in
rm -rf ./openwrt/target/linux/*
rm -rf ./openwrt/package/kernel/linux/*
cp -f ./openwrt_release/include/version.mk ./openwrt/include/version.mk
cp -f ./openwrt_release/include/kernel.mk ./openwrt/include/kernel.mk
cp -f ./openwrt_release/include/kernel-5.10 ./openwrt/include/kernel-5.10
cp -f ./openwrt_release/include/kernel-version.mk ./openwrt/include/kernel-version.mk
cp -f ./openwrt_release/include/toolchain-build.mk ./openwrt/include/toolchain-build.mk
cp -f ./openwrt_release/include/kernel-defaults.mk ./openwrt/include/kernel-defaults.mk
cp -f ./openwrt_release/package/base-files/image-config.in ./openwrt/package/base-files/image-config.in
cp -f ./openwrt_release/version ./openwrt/version
cp -f ./openwrt_release/version.date ./openwrt/version.date
cp -rf ./openwrt_release/target/linux/* ./openwrt/target/linux/
cp -rf ./openwrt_release/package/kernel/linux/* ./openwrt/package/kernel/linux/

# 获取源代码
#git clone -b main --depth 1 https://github.com/Lienol/openwrt.git openwrt-lienol
#git clone -b main --depth 1 https://github.com/Lienol/openwrt-packages packages-lienol
#git clone -b main --depth 1 https://github.com/Lienol/openwrt-luci luci-lienol
#git clone -b linksys-ea6350v3-mastertrack --depth 1 https://github.com/NoTengoBattery/openwrt NoTengoBattery

exit 0
