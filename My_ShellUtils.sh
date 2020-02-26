#!/bin/sh
#使用到的命令集 grep(查找相关) cut(字符串操作相关GNU coreutils) echo(打印相关) sed(对文件增删改查GNU sed)

# 换机器要改的变量
MACHINE_PATH='/Users/wangzhiguo'
ROOT_PATH="$MACHINE_PATH/Downloads/Learns/Guo_Company_Svn"
GRADLE_PATH="$MACHINE_PATH/.gradle/wrapper/dists/gradle-5.4.1-all/3221gyojl5jsh0helicew7rwx/gradle-5.4.1/bin/gradle" 

BUILD_ROOT_PATH="$MACHINE_PATH/Downloads/Learns/MyGithubs/Android_ShellBuilding/SanTiYun/Stand_Sdk"
CACHE_DIR_PATH="$BUILD_ROOT_PATH/Cache"

PROJECT_PATH='/GitLab/3TClient/SDK/Demo/android/WS_ANDROID_MOMODemo'

checkFileParentDirAndMake(){ #1 string
    tarStr="/"
    string=$1
    strArray=(${string//\// }) # 分割字符串，以 / 斜杠为分隔符，获得一个字符数组。
    strLen=${#strArray[*]} # 获取字符数组的长度
    end=$[$strLen-1] # 进行逻辑运算
    for (( i = 0; i < $strLen; i++ )); do
        if [[ $i != $end ]]; then
            strVar=${strArray[i]}
            tarStr+=$strVar"/"
        fi
    done
    sudo mkdir -p $tarStr
    echo $tarStr
}


# 检查文件夹都是否存在

sudo mkdir -p $CACHE_DIR_PATH



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
TTTRtcEngine='/wstechapi/src/main/java/com/wushuangtech/wstechapi/TTTRtcEngine.java'
TTTRtcEngineImpl='/wstechapi/src/main/java/com/wushuangtech/wstechapi/internal/TTTRtcEngineImpl.java'
GlobalHolder='/enterconfapi/src/main/java/com/wushuangtech/library/GlobalHolder.java'
GlobalConfig='/enterconfapi/src/main/java/com/wushuangtech/library/GlobalConfig.java';


