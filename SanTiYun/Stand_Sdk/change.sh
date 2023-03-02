#!/bin/sh
#使用到的命令集 grep(查找相关) cut(字符串操作相关GNU coreutils) echo(打印相关) sed(对文件增删改查GNU sed)

# 所用的标记
# 1.unitySdk 是否是unity使用
# 2.videoModule 是否打包视频模块
# 4.rtmpModule 是否打包rtmp模块
# 5.ijkModule 是否打包ijk模块
# 6.armv8a 是否打包64的so库
# 7.branch_hz 好赞客户
# 8.camera2 摄像头新的api
# 9.softEncode 强制使用软编
# 10.branch_ty 泰岳客户
# 11.branch_dj 典精客户
# 12.branch_dj 典精客户
# 13.version_number 版本号
# 14.version_type 版本类型

# 二、字符串比较运算符（请注意引号的使用，这是防止空格扰乱代码的好方法） 
#  1. -z string  如果 string长度为零，则为真 如：  [ -z "$myvar" ]
#  2. -n string  如果 string长度非零，则为真  如： [ -n "$myvar" ]
#  3. string1= string2  如果 string1与 string2相同，则为真 如：  ["$myvar" = "one two three"]
#  4. string1!= string2  如果 string1与 string2不同，则为真 如：  ["$myvar" != "one two three"]

#/Users/wangzhiguo/.gradle/wrapper/dists/gradle-4.6-all/bcst21l2brirad8k2ben1letg/gradle-4.6/bin/gradle
#/Users/wangzhiguo/.gradle/wrapper/dists/gradle-5.1.1-all/97z1ksx6lirer3kbvdnh7jtjg/gradle-5.1.1/bin


# echo "======="
# echo "armv8a : "$armv8a
# echo "unitySdk : "$unitySdk
# echo "videoModule : "$videoModule
# echo "rtmpModule : "$rtmpModule
# echo "ijkModule : "$ijkModule

sourceTempDir='/Users/wangzhiguo/Downloads/Learns/Guo_Company_Svn/GitLab/3TClient/SDK/Demo/android/WS_ANDROID_MOMODemo';
baleSourceDir='/Users/wangzhiguo/Desktop/sh_warehouse/Bale_AAR/Source';
baleResultDir='/Users/wangzhiguo/Desktop/sh_warehouse/Bale_AAR/Result';
gradlePath="/Users/wangzhiguo/.gradle/wrapper/dists/gradle-5.4.1-all/3221gyojl5jsh0helicew7rwx/gradle-5.4.1/bin/gradle"
appLibsDir='/app/libs'
wstechapiLibsDir='/wstechapi/libs'
enterconfapiLibsDir='/enterconfapi/libs'
enterconfapiChatDir='/enterconfapi/src/main/java/com/wushuangtech/expansion/chatlibrary'
jniDir='/armeabi-v7a'
v8aJniDir='/arm64-v8a'

# 需要修改的文件
TTTRtcEngine='/wstechapi/src/main/java/com/wushuangtech/wstechapi/TTTRtcEngine.java'
TTTRtcEngineImpl='/wstechapi/src/main/java/com/wushuangtech/wstechapi/internal/TTTRtcEngineImpl.java'
TTTRtcUnity='/wstechapi/src/main/java/com/wushuangtech/wstechapi/internal/TTTRtcUnity.java'
TTTRtcIjkModule='/wstechapi/src/main/java/com/wushuangtech/wstechapi/internal/TTTRtcIjkModule.java'
TTTVideoModule='/wstechapi/src/main/java/com/wushuangtech/wstechapi/internal/TTTVideoModule.java'
TTTRtmpModule='/wstechapi/src/main/java/com/wushuangtech/wstechapi/internal/TTTRtmpModule.java'

EnterConfApiImpl='/enterconfapi/src/main/java/com/wushuangtech/api/EnterConfApiImpl.java'
GlobalHolder='/enterconfapi/src/main/java/com/wushuangtech/library/GlobalHolder.java'
GlobalConfig='/enterconfapi/src/main/java/com/wushuangtech/library/GlobalConfig.java';

videoSo1='/libcodec_ttt.so'
videoSo3='/libyuv_ttt.so'
ijkplayerSo1='/libijkffmpeg_ttt.so'
ijkplayerSo2='/libijkplayer_ttt.so'
ijkplayerSo3='/libijksdl_ttt.so'
ijkplayerAar1='/ijkplayer_exo.aar'
ijkplayerAar2='/ijkplayer_java.aar'
chatLib1='/okhttp-3.4.1.jar'
chatLib2='/okio-1.9.0.jar'
chatLib3='/oss-android-sdk-release.jar'
rtmpSo1='/librtmp.so'
unitySo1='/libTTTRtcEngine.so'
audioSo1='/libAudioDecoder.so'
audioSo2='/libAudioEffect.so'

IJK_MODULE_TAG1='IJK_MODULE_CreateIjkRendererView'
IJK_MODULE_TAG2='IJK_MODULE_handleIJKModule'
IJK_MODULE_TAG3='IJK_MODULE_API'
IJK_MODULE_TAG4='IJK_MODULE_API_PACK'
RTMP_MODULE_TAG1='RTMP_MODULE_handleRTMPModule'

comSearchTag='shell'
spaceTag='$$'
delete=1
replace=2

targetFileName=""
targetFilePath=""
targetFilePathAbs=""

echo "======="
echo "armv8a : "$armv8a
echo "unitySdk : "$unitySdk
echo "videoModule : "$videoModule
echo "rtmpModule : "$rtmpModule
echo "ijkModule : "$ijkModule
echo "======="

time=$(date "+%Y_%m_%d")
echo "${time}"

echo "version_number : "$version_number" | version_type : "$version_type
read -p "输入SDK打包日期，不输入代表今天:" aarDate

if [[ -z "$aarDate" ]]; then
    aarDate=$time
fi

local_version_number='2.3.0'
if [[ -n "$version_number" ]]; then
    local_version_number=$version_number
fi

targetAAR="3T_Native_SDK_for_Android_V"$local_version_number"_Full($aarDate).aar"
if [ $videoModule -eq 0 ];then
    targetAAR="3T_Native_SDK_for_Android_V"$local_version_number"_Voice($aarDate).aar"
fi
echo "targetAAR : "$targetAAR
executeComReplaceCommand(){ #$1-targetFilePathAbs #$2-isEmbedded 
    result=`grep -n $comSearchTag $1 | gawk '{print $1}' FS=":"`; #Link_1
    for i in $result; do
        sed -i "$i s/implementation /compile /g" $1
        sed -i "s/testImplementation /testCompile /g" $1
        sed -i "s/androidTestImplementation /androidTestCompile /g" $1
        if [[ ! -n "$2" ]] ;then
            sed -i "s/api /compile /g" $1
            sed -i "s/api(/compile(/g" $1
        else
            sed -i "s/api /embedded /g" $1
            sed -i "s/api(/embedded(/g" $1
        fi
    done
}

executeSimpleComReplaceCommand(){ #$1-targetFileName #$2-isEmbedded 
    executeCpFile $1

    targetFilePathAbs=$sourceTempDir$1;
    executeComReplaceCommand $targetFilePathAbs $2
}

#shell函数参数获取，通过$符合加数字按顺序，若超过10位，第11位需要${n}。
executeCommand(){ # $1-targetFileName , $2-targetSearch , $3-targetFilePathAbs , $4-type , $5-replaceContent , $6-targetLineEnd
    #替换_为空格，参数不能带空格
    targetReplace=${5//$spaceTag/ }; #Link_3
    #查找搜索目标所在行数
    location=`grep -n $2 $3`
    #分割字符串获取行数
    lineNumber=`echo $location| cut -d : -f 1`
    if [[ $4 == $delete ]]; then
        sed -i $lineNumber'd' $3 #删除
    elif [[ $4 == $replace ]]; then
        # 判断第六个参数是否为空，-n是判断字符串长度是否为0，如果为0则-n返回false，如果不为0则-n返回true，感叹号翻转
        if [[ ! -n "$6" ]] ;then #Link_4
            sed -i $lineNumber"c $targetReplace" $3 #替换
        else
            lineNumberEnd=$[$lineNumber+${6}]
            tempStr=${lineNumber}','${lineNumberEnd}
            sed -i $tempStr"c $targetReplace" $3 #替换
        fi
    fi
}

executeCpFile(){ # $1-targetFilePath
    if [ ! -f $sourceTempDir$1 ];then
        echo "要拷贝的源文件不存在 ："$1
        return 0
    fi

    echo "拷贝源文件到 ："$baleSourceDir$1
    if [ -f $baleSourceDir$1 ];then
        rm $baleSourceDir$1;
    fi
    cp $sourceTempDir$1 $baleSourceDir$1;
}

# 要修改的文件列表
modify_file_list=("${TTTRtcEngine}" "${TTTRtcEngineImpl}" "${TTTRtcUnity}" "${TTTRtcIjkModule}" "${TTTVideoModule}" "${TTTRtmpModule}"
    "${EnterConfApiImpl}" "${GlobalConfig}")
modify_file_list_len=${#modify_file_list[@]}
for (( i = 0; i < $modify_file_list_len; i++ )); do
    file=${modify_file_list[i]}
    executeCpFile $file
done
#----------------------------------------------------------------------------------------------------------

tempSourceV8aJniDir=$sourceTempDir$wstechapiLibsDir$v8aJniDir;
tempBaleV8aJniDir=$baleSourceDir$wstechapiLibsDir$v8aJniDir;
if [[ -d $tempSourceV8aJniDir ]]; then
    if [[ -d $tempSourceV8aJniDir ]]; then
        rm -rf $tempBaleV8aJniDir;
    fi
    cp  -r $tempSourceV8aJniDir $tempBaleV8aJniDir;

    if [[ $armv8a -eq 0 ]]; then
        rm -rf $tempSourceV8aJniDir;
    else
        if [ $videoModule -eq 0 ];then
            if [[ -f $tempSourceV8aJniDir$videoSo1 ]]; then
                rm $tempSourceV8aJniDir$videoSo1
            fi

            if [[ -f $tempSourceV8aJniDir$videoSo3 ]]; then
                rm $tempSourceV8aJniDir$videoSo3
            fi
        fi

        if [ $rtmpModule -eq 0 ];then
            if [[ -f $tempSourceV8aJniDir$rtmpSo1 ]]; then
                rm $tempSourceV8aJniDir$rtmpSo1
            fi
        fi

        if [ $ijkModule -eq 0 ];then
            if [[ -f $tempSourceV8aJniDir$ijkplayerSo1 ]]; then
                rm $tempSourceV8aJniDir$ijkplayerSo1
            fi

            if [[ -f $tempSourceV8aJniDir$ijkplayerSo2 ]]; then
                rm $tempSourceV8aJniDir$ijkplayerSo2
            fi

            if [[ -f $tempSourceV8aJniDir$ijkplayerSo3 ]]; then
                rm $tempSourceV8aJniDir$ijkplayerSo3
            fi
        fi

        if [[ $unitySdk -eq 0 ]]; then
            if [[ -f $tempSourceV8aJniDir$unitySo1 ]]; then
                rm $tempSourceV8aJniDir$unitySo1
            fi
        fi

        if [ $audioEffectModule -eq 0 ];then
            if [[ -f $tempSourceV8aJniDir$audioSo2 ]]; then
                rm $tempSourceV8aJniDir$audioSo2
            fi
        fi
    fi
fi

#----------------------------------------------------------------------------------------------------------

if [[ $unitySdk -eq 0 ]]; then
    cp $sourceTempDir$wstechapiLibsDir$jniDir$unitySo1 $baleSourceDir$wstechapiLibsDir$jniDir$unitySo1;
    rm $sourceTempDir$wstechapiLibsDir$jniDir$unitySo1
fi

#----------------------------------------------------------------------------------------------------------

targetFilePath='/build.gradle';
executeCpFile $targetFilePath

targetFileName="build"
targetSearch='classpath';
targetFilePathAbs=$sourceTempDir$targetFilePath;
replaceContent='classpath'$spaceTag''\''com.android.tools.build:gradle:3.2.1'\''';
executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

#----------------------------------------------------------------------------------------------------------

targetFilePath='/gradle/wrapper/gradle-wrapper.properties';
executeCpFile $targetFilePath

targetFileName="gradle-wrapper"
targetSearch='distributionUrl';
targetFilePathAbs=$sourceTempDir$targetFilePath;
replaceContent='distributionUrl=https\'\\'\://services.gradle.org/distributions/gradle-4.6-all.zip';
executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

#----------------------------------------------------------------------------------------------------------

targetFilePath='/wstechapi/build.gradle'
executeCpFile $targetFilePath

targetFileName='build'
targetSearch='kezong';
targetFilePathAbs=$sourceTempDir$targetFilePath;
replaceContent='apply'$spaceTag'plugin:'$spaceTag"\'com.kezong.fat-aar\'";
executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

targetSearch='Shell_Visible'
filePath=$sourceTempDir"/wstechapi/build.gradle"
sed -i "s/\/\/$targetSearch/ /g" $filePath

sed -i "s/api project/\/\/api project/g" $filePath
sed -i "s/api(/\/\/api(/g" $filePath
#----------------------------------------------------------------------------------------------------------

if [[ -n "$version_number" ]]; then
    #修改版本号
    targetFileName="GlobalConfig"
    targetFilePath=$GlobalConfig
    targetSearch='SDK_VERSION_NUMBER';
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    replaceContent="public"$spaceTag"static"$spaceTag"final"$spaceTag"String"$spaceTag"SDK_VERSION_NUMBER"$spaceTag"="$spaceTag"\"$version_number\";";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

if [[ -n "$version_type" ]]; then
    #修改版本类型
    targetFileName="GlobalConfig"
    targetFilePath=$GlobalConfig
    targetSearch='SDK_VERSION_TYPE';
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    replaceContent="public"$spaceTag"static"$spaceTag"final"$spaceTag"String"$spaceTag"SDK_VERSION_TYPE"$spaceTag"="$spaceTag"\"$version_type\";";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

if [ $videoModule -eq 0 ];then
    echo '***删除视频模块***'
    # 纯音频SDK删除视频相关文件
    cp $sourceTempDir$wstechapiLibsDir$jniDir$videoSo1 $baleSourceDir$wstechapiLibsDir$jniDir$videoSo1;
    if [ -f $sourceTempDir$wstechapiLibsDir$jniDir$videoSo1 ];then
        rm $sourceTempDir$wstechapiLibsDir$jniDir$videoSo1;
    fi
    cp $sourceTempDir$wstechapiLibsDir$jniDir$videoSo3 $baleSourceDir$wstechapiLibsDir$jniDir$videoSo3;
    if [ -f $sourceTempDir$wstechapiLibsDir$jniDir$videoSo3 ];then
        rm $sourceTempDir$wstechapiLibsDir$jniDir$videoSo3;
    fi

    targetFilePath='/wstechapi/src/main/java/com/wushuangtech/wstechapi/internal/TTTVideoModule.java'
    executeCpFile $targetFilePath
    rm $sourceTempDir$targetFilePath;

    #修改纯音频TAG
    targetFilePath=$GlobalConfig
    targetFileName="GlobalConfig"
    targetSearch='mIsVoiceSDK';
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    replaceContent="public"$spaceTag"static"$spaceTag"final"$spaceTag"boolean"$spaceTag"mIsVoiceSDK"$spaceTag"="$spaceTag"true;";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

    #————————————————————————————————————————————————————————————

    targetFileName="TTTRtcEngineImpl"
    targetFilePathAbs=$sourceTempDir$TTTRtcEngineImpl;
    targetSearch='IJK_handleVideoModuleTG';
    replaceContent='return'$spaceTag'null;';
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

    targetSearch='IJK_handleVideoModuleTGEvent'
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

    #————————————————————————————————————————————————————————————

    targetFilePath='/wstechapi/src/main/java/com/wushuangtech/wstechapi/internal/TTTRtcUnity.java';
    executeCpFile $targetFilePath

    targetFileName="TTTRtcUnity"
    targetSearch='IJK_handleVideoModuleTG';
    targetFilePathAbs=$sourceTempDir$targetFilePath
    replaceContent='return'$spaceTag'null;';
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

    targetSearch='IJK_handleVideoModuleTGEvent'
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi


######### IJK模块 #########

if [ $ijkModule -eq 0 ];then
    echo '***删除IJK模块***'
    cp $sourceTempDir$wstechapiLibsDir$jniDir$ijkplayerSo1 $baleSourceDir$wstechapiLibsDir$jniDir$ijkplayerSo1;
    if [ -f $sourceTempDir$wstechapiLibsDir$jniDir$ijkplayerSo1 ];then
        rm $sourceTempDir$wstechapiLibsDir$jniDir$ijkplayerSo1;
    fi
    cp $sourceTempDir$wstechapiLibsDir$jniDir$ijkplayerSo2 $baleSourceDir$wstechapiLibsDir$jniDir$ijkplayerSo2;
    if [ -f $sourceTempDir$wstechapiLibsDir$jniDir$ijkplayerSo2 ];then
        rm $sourceTempDir$wstechapiLibsDir$jniDir$ijkplayerSo2;
    fi
    cp $sourceTempDir$wstechapiLibsDir$jniDir$ijkplayerSo3 $baleSourceDir$wstechapiLibsDir$jniDir$ijkplayerSo3;
    if [ -f $sourceTempDir$wstechapiLibsDir$jniDir$ijkplayerSo3 ];then
        rm $sourceTempDir$wstechapiLibsDir$jniDir$ijkplayerSo3;
    fi
    cp $sourceTempDir$wstechapiLibsDir$ijkplayerAar1 $baleSourceDir$wstechapiLibsDir$ijkplayerAar1;
    if [ -f $sourceTempDir$wstechapiLibsDir$ijkplayerAar1 ];then
        rm $sourceTempDir$wstechapiLibsDir$ijkplayerAar1;
    fi
    cp $sourceTempDir$wstechapiLibsDir$ijkplayerAar2 $baleSourceDir$wstechapiLibsDir$ijkplayerAar2;
    if [ -f $sourceTempDir$wstechapiLibsDir$ijkplayerAar2 ];then
        rm $sourceTempDir$wstechapiLibsDir$ijkplayerAar2;
    fi

    # 删除TTTRtcIjkModule文件
    targetFilePath='/wstechapi/src/main/java/com/wushuangtech/wstechapi/internal/TTTRtcIjkModule.java'
    executeCpFile $targetFilePath
    rm $sourceTempDir$targetFilePath;

    # 删除CreateIjkRendererView函数接口。
    targetFileName="TTTRtcEngine"
    targetFilePathAbs=$sourceTempDir$TTTRtcEngine;
    targetSearch=$IJK_MODULE_TAG1;
    replaceContent='//';
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

    targetSearch="ttt.ijk.media.exo.widget.media.IjkVideoView";
    replaceContent='//';
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

    # 删除 CreateIjkRendererView 函数的实现。
    targetFileName="TTTRtcEngineImpl"
    targetFilePathAbs=$sourceTempDir$TTTRtcEngineImpl;
    targetSearch=$IJK_MODULE_TAG1;
    replaceContent='//';
    targetLineEnd=23 # CreateIjkRendererView 函数的实现若修改了，需要更改行数。
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent $targetLineEnd

    targetSearch="ttt.ijk.media.exo.widget.media.IjkVideoView";
    replaceContent='//';
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

    # 改变函数 handleIJKModule 实现。
    targetSearch=$IJK_MODULE_TAG2;
    replaceContent='return'$spaceTag'null;';
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

    # 删除gradle对aar的引用
    targetFileName='build.gradle';
    targetFilePathAbs=$sourceTempDir"/wstechapi/build.gradle";
    targetSearch=$IJK_MODULE_TAG4;
    replaceContent='//';
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent #执行二遍
fi

if [ $rtmpModule -eq 0 ];then
    echo '***删除RTMP模块***'
    cp $sourceTempDir$wstechapiLibsDir$jniDir$rtmpSo1 $baleSourceDir$wstechapiLibsDir$jniDir$rtmpSo1;
    if [ -f $sourceTempDir$wstechapiLibsDir$jniDir$rtmpSo1 ];then
        rm $sourceTempDir$wstechapiLibsDir$jniDir$rtmpSo1;
    fi

    # 删除TTTRtmpModule文件
    targetFilePath='/wstechapi/src/main/java/com/wushuangtech/wstechapi/internal/TTTRtmpModule.java'
    executeCpFile $targetFilePath
    rm $sourceTempDir$targetFilePath;

    # 删除 handleRTMPModule 函数的实现。
    targetFileName="TTTRtcEngineImpl"
    targetFilePathAbs=$sourceTempDir$TTTRtcEngineImpl;
    targetSearch=$RTMP_MODULE_TAG1;
    replaceContent='return'$spaceTag'null;';
    targetLineEnd=3 # handleRTMPModule 函数的实现若修改了，需要更改行数。
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent $targetLineEnd
fi

if [ $audioEffectModule -eq 0 ];then
     echo '***删除音效库***'
     cp $sourceTempDir$wstechapiLibsDir$jniDir$audioSo2 $baleSourceDir$wstechapiLibsDir$jniDir$audioSo2;
    if [ -f $sourceTempDir$wstechapiLibsDir$jniDir$audioSo2 ];then
        rm $sourceTempDir$wstechapiLibsDir$jniDir$audioSo2;
    fi
fi

# 家有课堂客户必须使用camera2 和 软编
if [[ $camera2 -eq 1 ]]; then
    targetFilePath=$GlobalConfig
    targetFileName="GlobalConfig"
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    targetSearch='mUseCamera2Api';
    replaceContent="public"$spaceTag"static"$spaceTag"boolean"$spaceTag"mUseCamera2Api"$spaceTag"="$spaceTagce"true;";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

# 家有课堂客户必须使用软编
if [[ $softEncode -eq 1 ]]; then
    targetFilePath=$GlobalConfig
    targetFileName="GlobalConfig"
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    targetSearch='mTestSoftEncode';
    replaceContent="public"$spaceTag"static"$spaceTag"boolean"$spaceTag"mTestSoftEncode"$spaceTag"="$spaceTagce"true;";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

if [[ $branch_hz -eq 1 ]]; then
    targetFilePath=$GlobalConfig
    targetFileName="GlobalConfig"
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    targetSearch='mBranch';
    replaceContent="public"$spaceTag"static"$spaceTag"int"$spaceTag"mBranch"$spaceTag"="$spaceTagce"LocalSDKConstants.BRANCH_CLIENT_HZ;";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

if [[ $branch_ty -eq 1 ]]; then
    targetFilePath=$GlobalConfig
    targetFileName="GlobalConfig"
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    targetSearch='mBranch';
    replaceContent="public"$spaceTag"static"$spaceTag"int"$spaceTag"mBranch"$spaceTag"="$spaceTagce"LocalSDKConstants.BRANCH_CLIENT_TY;";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent

    # 删除v7 v8伴奏库
    cp $sourceTempDir$wstechapiLibsDir$jniDir$audioSo1 $baleSourceDir$wstechapiLibsDir$jniDir$audioSo1;
    if [ -f $sourceTempDir$wstechapiLibsDir$jniDir$audioSo1 ];then
        rm $sourceTempDir$wstechapiLibsDir$jniDir$audioSo1;
    fi

    cp $sourceTempDir$wstechapiLibsDir$v8aJniDir$audioSo1 $baleSourceDir$wstechapiLibsDir$v8aJniDir$audioSo1;
    if [ -f $sourceTempDir$wstechapiLibsDir$v8aJniDir$audioSo1 ];then
        rm $sourceTempDir$wstechapiLibsDir$v8aJniDir$audioSo1;
    fi

    # 注释掉 System.loadLibrary("AudioDecoder");
    targetFilePath=$EnterConfApiImpl
    targetFileName="EnterConfApiImpl"
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    targetSearch='System.loadLibrary("AudioDecoder")';
    replaceContent="//";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

if [[ $branch_dj -eq 1 ]]; then
    targetFilePath=$GlobalConfig
    targetFileName="GlobalConfig"
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    targetSearch='mBranch';
    replaceContent="public"$spaceTag"static"$spaceTag"int"$spaceTag"mBranch"$spaceTag"="$spaceTagce"LocalSDKConstants.BRANCH_CLIENT_DJ;";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

if [[ $branch_miaomiao -eq 1 ]]; then
    targetFilePath=$GlobalConfig
    targetFileName="GlobalConfig"
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    targetSearch='mBranch';
    replaceContent="public"$spaceTag"static"$spaceTag"int"$spaceTag"mBranch"$spaceTag"="$spaceTagce"LocalSDKConstants.BRANCH_CLIENT_MIAOMIAO;";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

if [[ $branch_jjyy -eq 1 ]]; then
    targetFilePath=$GlobalConfig
    targetFileName="GlobalConfig"
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    targetSearch='mBranch';
    replaceContent="public"$spaceTag"static"$spaceTag"int"$spaceTag"mBranch"$spaceTag"="$spaceTagce"LocalSDKConstants.BRANCH_CLIENT_JIUJIU;";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

if [[ $branch_tctd -eq 1 ]]; then
    targetFilePath=$GlobalConfig
    targetFileName="GlobalConfig"
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    targetSearch='mBranch';
    replaceContent="public"$spaceTag"static"$spaceTag"int"$spaceTag"mBranch"$spaceTag"="$spaceTagce"LocalSDKConstants.BRANCH_CLIENT_TC;";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

if [[ $branch_yq -eq 1 ]]; then
    targetFilePath=$GlobalConfig
    targetFileName="GlobalConfig"
    targetFilePathAbs=$sourceTempDir$targetFilePath;
    targetSearch='mBranch';
    replaceContent="public"$spaceTag"static"$spaceTag"int"$spaceTag"mBranch"$spaceTag"="$spaceTagce"LocalSDKConstants.BRANCH_CLIENT_YQ;";
    executeCommand $targetFileName $targetSearch $targetFilePathAbs $replace $replaceContent
fi

#----------------------------------------------------------------------------------------------------------

read -p "输入SDK打包日期，不输入代表今天:" aarDate2222

# 开始打包
desDir="/Users/wangzhiguo/Desktop/Temporary-Files/SDK_Kit/TTTRtcEngine_AndroidKitWrap/TTTRtcEngine_AndroidKit";
srcDir=$sourceTempDir"/wstechapi/build/outputs/aar";
# 进入工程目录
cd $sourceTempDir"/wstechapi"
# 执行gradle
/Users/wangzhiguo/.gradle/wrapper/dists/gradle-4.6-all/bcst21l2brirad8k2ben1letg/gradle-4.6/bin/gradle clean
/Users/wangzhiguo/.gradle/wrapper/dists/gradle-4.6-all/bcst21l2brirad8k2ben1letg/gradle-4.6/bin/gradle assembleRelease 
# 进入生成的aar目录
cd $srcDir
# 替换文件名
for files in `ls`
do
    # 拷贝到指定目录
    cp $srcDir"/"$files $desDir"/"$targetAAR
done

read -p "是否需要同步到其他Demo中:" isSyncOtherDemo
if [[ isSyncOtherDemo == 1 ]]; then
    . /Users/wangzhiguo/Desktop/sh_warehouse/copy_aar_to_demo.sh;
fi

# 还原文件
. /Users/wangzhiguo/Downloads/Learns/MyGithubs/Android_ShellBuilding/SanTiYun/Stand_Sdk/restore.sh;

rm -rf $desDir"/temp"
unzip -o "$desDir/$targetAAR" -d $desDir"/temp"
unzip -j -o "$desDir/temp/classes.jar" "com/wushuangtech/library/GlobalConfig.class" -d $desDir"/temp"

#打开目录
open $desDir

#----------------------------------------------------------------------------------------------------------

if [[ $videoModule -eq 0 ]]; then
    projectPath="/Users/wangzhiguo/Downloads/Learns/Guo_Company_Svn/GitHub/AudioChat/app"
    projectPathLib="$projectPath/libs"
else
    projectPath="/Users/wangzhiguo/Downloads/Learns/Guo_Company_Svn/GitLab/3TClient/SDK/Demo/android/WS_ANDROID_MOMODemo/app"
    projectPathLib="$projectPath/libs"
fi

read -p "是否开始打包apk验证aar? 0表示不验证 : " isWatchApk
if [[ $isWatchApk -ne 0 ]]; then
    cd $projectPathLib
    for files in `ls`
    do
        extension=${files##*.}
        if [[ $extension = "aar" ]]; then
             rm $files
        fi
    done
    cp $desDir/$targetAAR $projectPathLib"/"$targetAAR
    cd $projectPath
    $gradlePath clean
    $gradlePath assembleDebug 

    read -p "打包成功，确保连接上了手机，准备安装apk，0表示不安装 : " installApk
    if [[ $installApk -ne 0 ]]; then
        adb install "$projectPath/build/outputs/apk/debug/app-debug.apk"
    fi
    open $projectPath
fi

read -p "结束窗口? : " exit

