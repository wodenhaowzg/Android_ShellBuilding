#!/bin/sh

v7_stand_sdk_video=1
v7_stand_sdk_video_ijk=2
v7_stand_sdk_voice=3
v8_stand_sdk_video=4
v8_stand_sdk_video_ijk=5
v8_stand_sdk_voice=6

stand_video=1
branch_stand_video=101
branch_stand_voice=200

armv8a=0
videoModule=1
rtmpModule=1
ijkModule=1
unitySdk=0
audioEffectModule=0

version_number="2.7.0"

setModule(){
    armv8a=$1
    videoModule=$2
    rtmpModule=$3
    ijkModule=$4
}

echo "1 --- v7-不带ijk"
echo "2 --- v7-带ijk"
echo "3 --- v7-纯音频"
echo "4 --- v8-不带ijk"
echo "5 --- v8-带ijk"
echo "6 --- v8-纯音频"


read -p "打包分支？" branch
if [[ $branch -eq $v7_stand_sdk_video ]]; then
    setModule 0 1 1 0
elif [[ $branch -eq $v7_stand_sdk_video_ijk ]]; then
    setModule 0 1 1 1
elif [[ $branch -eq $v7_stand_sdk_voice ]]; then
    setModule 0 0 0 0
    version_type="Voice"
elif [[ $branch -eq $v8_stand_sdk_video ]]; then
    setModule 1 1 1 0
elif [[ $branch -eq $v8_stand_sdk_video_ijk ]]; then
    setModule 1 1 1 1
elif [[ $branch -eq $v8_stand_sdk_voice ]]; then
    setModule 1 0 0 0
    version_type="Voice"
fi

. /Users/wangzhiguo/Desktop/sh_warehouse/MoMo_Package/change.sh;