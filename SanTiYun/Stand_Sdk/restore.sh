#!/bin/sh
#使用到的命令集 grep(查找相关) cut(字符串操作相关) echo(打印相关) sed(对文件增删改查)

function cpBaleSourceToSource(){
	if [ -f $baleSourceDir$targetFileName ];then
		cp $baleSourceDir$targetFileName $sourceTempDir$targetFileName
	fi
}

#----------------------------------------------------------------------------------------------------------

targetFileName='/build.gradle';
cpBaleSourceToSource;

#----------------------------------------------------------------------------------------------------------

targetFileName='/gradle/wrapper/gradle-wrapper.properties';
cpBaleSourceToSource;

#----------------------------------------------------------------------------------------------------------

targetFileName='/wstechapi/build.gradle';
cpBaleSourceToSource;

#----------------------------------------------------------------------------------------------------------

targetFileName=$GlobalConfig
cpBaleSourceToSource;
targetFileName=$EnterConfApiImpl
cpBaleSourceToSource

targetFileName=$TTTRtcEngine
cpBaleSourceToSource
targetFileName=$TTTRtcEngineImpl
cpBaleSourceToSource
targetFileName=$TTTRtmpModule
cpBaleSourceToSource
targetFileName=$TTTVideoModule
cpBaleSourceToSource;
targetFileName=$TTTRtcUnity
cpBaleSourceToSource;
targetFileName=$TTTRtcIjkModule
cpBaleSourceToSource

if [ $videoModule -eq 0 ];then
	targetFileName='/wstechapi/libs/armeabi-v7a/libcodec_ttt.so';
	cpBaleSourceToSource;

	targetFileName='/wstechapi/libs/armeabi-v7a/libyuv_ttt.so';
	cpBaleSourceToSource;
fi

#----------------------------------------------------------------------------------------------------------

if [ $ijkModule -eq 0 ];then
	targetFileName=$wstechapiLibsDir$jniDir$ijkplayerSo1;
	cpBaleSourceToSource;
	targetFileName=$wstechapiLibsDir$jniDir$ijkplayerSo2;
	cpBaleSourceToSource;
	targetFileName=$wstechapiLibsDir$jniDir$ijkplayerSo3;
	cpBaleSourceToSource;
	targetFileName=$wstechapiLibsDir$ijkplayerAar1;
	cpBaleSourceToSource;
	targetFileName=$wstechapiLibsDir$ijkplayerAar2;
	cpBaleSourceToSource;
fi

if [ $rtmpModule -eq 0 ];then
	targetFileName=$wstechapiLibsDir$jniDir$rtmpSo1;
	cpBaleSourceToSource;
	targetFileName=$TTTRtcEngineImpl
	cpBaleSourceToSource
fi

if [ $unitySdk -eq 0 ];then
	targetFileName=$wstechapiLibsDir$jniDir$unitySo1;
	cpBaleSourceToSource;
fi

if [ $armv8a -eq 0 ];then
	targetFileName=$wstechapiLibsDir$v8aJniDir;
	cp -r $baleSourceDir$targetFileName $sourceTempDir$targetFileName
else
	if [ $videoModule -eq 0 ];then
		targetFileName=$wstechapiLibsDir$v8aJniDir$videoSo1;
		cpBaleSourceToSource
		targetFileName=$wstechapiLibsDir$v8aJniDir$videoSo2;
		cpBaleSourceToSource
		targetFileName=$wstechapiLibsDir$v8aJniDir$videoSo3;
		cpBaleSourceToSource
	fi

	if [ $rtmpModule -eq 0 ];then
		targetFileName=$wstechapiLibsDir$v8aJniDir$rtmpSo1;
		cpBaleSourceToSource
	fi

	if [ $ijkModule -eq 0 ];then
		targetFileName=$wstechapiLibsDir$v8aJniDir$ijkplayerSo1;
		cpBaleSourceToSource
		targetFileName=$wstechapiLibsDir$v8aJniDir$ijkplayerSo2;
		cpBaleSourceToSource
		targetFileName=$wstechapiLibsDir$v8aJniDir$ijkplayerSo3;
		cpBaleSourceToSource
	fi

	if [[ $unitySdk -eq 0 ]]; then
		targetFileName=$wstechapiLibsDir$v8aJniDir$unitySo1;
		cpBaleSourceToSource
	fi

	 if [ $audioEffectModule -eq 0 ];then
		targetFileName=$wstechapiLibsDir$v8aJniDir$audioSo2;
		cpBaleSourceToSource
	fi
fi

if [ $audioEffectModule -eq 0 ];then
	targetFileName=$wstechapiLibsDir$jniDir$audioSo2;
	cpBaleSourceToSource;
fi


#----------------------------------------------------------------------------------------------------------
