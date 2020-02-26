#!/bin/sh

branch_dke=1
branch_dj=2
branch_hz=3
branch_tctd=4
branch_miaomiao_video=5
branch_miaomiao_voice=6
branch_xlkj=7
branch_klkj=8
branch_jjyy=9
branch_ym=11
branch_jykt=12
branch_jyb=13
branch_tyjh=14
branch_ty=15

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

echo "1 --- 迪卡尔"
echo "2 --- 典精"
echo "3 --- 好赞"
echo "4 --- 同创天达"
echo "5 --- 喵喵视频"
echo "6 --- 喵喵音频"
echo "7 --- 小楼科技"
echo "8 --- 扩列科技"
echo "9 --- 久久语音"
echo "11 --- 远盟技术"
echo "12 --- 家有课堂"
echo "13 --- 教育版"
echo "14 --- 泰岳建行"
echo "15 --- 泰岳"

read -p "要给哪个客户打包？" branch

if [ $branch -eq $branch_dke ] || [ $branch -eq $branch_hz ] || [ $branch -eq $branch_jykt ] ; then
    setModule 0 1 1 0
elif [ $branch -eq $branch_tctd ] || [ $branch -eq $branch_miaomiao_video ]  || [ $branch -eq $branch_xlkj ] || [ $branch -eq $branch_ym ] 
    || [ $branch -eq $branch_jyb ] || [ $branch -eq $branch_ty ] ; then
    setModule 0 1 1 1
elif [[ $branch -eq $branch_dj ]]; then
    setModule 1 1 0 1
elif [ $branch -eq $branch_miaomiao_voice ]  || [ $branch -eq $branch_klkj ]   || [ $branch -eq $branch_jjyy ] ; then
    setModule 0 0 0 0
elif [[ $branch -eq $branch_tyjh ]]; then
    setModule 1 1 1 0
fi

if [[ $branch -eq $branch_hz ]]; then
    branch_hz=1
elif [[ $branch -eq $branch_dj ]]; then
    branch_dj=1
elif [ $branch -eq $branch_tctd ] || [ $branch -eq $branch_miaomiao_video ]  || [ $branch -eq $branch_miaomiao_voice ] ; then
    branch_miaomiao=1
elif [[ $branch -eq $branch_jjyy ]]; then
    branch_jjyy=1
elif [ $branch -eq $branch_tyjh ] || [ $branch -eq $branch_ty ] ; then
    branch_ty=1
fi

if [ $branch -eq $branch_miaomiao_voice ]  || [ $branch -eq $branch_klkj ]   || [ $branch -eq $branch_jjyy ] ; then
   version_type="Voice"
fi

if [[ $branch -eq $branch_jykt ]]; then
    camera2=1
    softEncode=1
fi

# . /Users/wangzhiguo/Desktop/sh_warehouse/MoMo_Package/change.sh;