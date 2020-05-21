#! /usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
export TZ=Asia/Kolkata
export TIME=$(date +"%S-%F")
export ZIPNAME=Triton-Storm-beta-${TIME}
ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
apt-get install -y tzdata
sudo apt install -y subversion
svn checkout https://github.com/Thagoo/4.9/trunk 
#git clone --depth=1 -j$(nproc --all) https://github.com/Thagoo/4.9 --single-branch triton -b kernel.lnx.4.9.r34-rel && cd *
git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 -b lineage-17.1 tc --depth=1 --single-branch
git clone https://github.com/Thagoo/AnyKernel3
echo cloning done
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=Thago
export CROSS_COMPILE=$(pwd)/tc/bin/aarch64-linux-android-
make mrproper
mkdir -p out
make O=out rolex_defconfig
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
        -d chat_id="$CID" \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=html" \
        -d text="build started"
make O=out -j$(nproc --all) -l$(nproc --all) | tee log.txt
if ! [ -a "out/arch/arm64/boot/Image.gz-dtb" ]; then    
   curl -F document=@log.txt "https://api.telegram.org/bot${TOKEN}/sendDocument" \
        -F chat_id=${CID} \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html" 
           exit 1
fi
cp out/arch/arm64/boot/Image.gz-dtb AnyKernel3
cd AnyKernel3
zip -r ${ZIPNAME}.zip *

curl -F document=@$ZIPNAME.zip "https://api.telegram.org/bot$TOKEN/sendDocument" \
        -F chat_id=$CID\
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html"  \
	-F caption="#triton #atmosphere follow @tboxxx for more updates"

