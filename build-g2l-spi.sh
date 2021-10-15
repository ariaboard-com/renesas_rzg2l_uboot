export ARCH="arm64"
export CORES=`getconf _NPROCESSORS_ONLN`
export CROSS_COMPILE="aarch64-none-elf-"
export WORKDIR="$(pwd)"
export PATH="${WORKDIR}/../gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf/bin:$PATH"

if [ x"$1" = x"mrprober" ]; then
   rm -rf build
fi

if [ ! -d build ]; then
    mkdir -p build
fi

#make O=build smarc-rzg2l_defconfig
make O=build rzg2l-novotech_defconfig
make O=build -j2

rm -rf deploy 2>/dev/null || true
mkdir -p deploy
cp -v build/u-boot-elf.srec deploy/
cp -v build/u-boot.bin deploy/
