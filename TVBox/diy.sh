#!/bin/bash

#echo '更改软件包名使共存'
#sed -i 's/com.github.tvbox.osc.tk/com.github.tvbox.osc.qtm/g' tv/app/build.gradle

# 未测试
#echo '修改为未降前 用于高版本安卓'
#sed -i '/minSdkVersion/d' tv/app/build.gradle
#sed -i '/com.github.tvbox.osc.tk/a\        minSdkVersion 21' tv/app/build.gradle
#sed -i '/targetSdkVersion/d' tv/app/build.gradle
#sed -i '/minSdkVersion/a\        targetSdkVersion 29' tv/app/build.gradle

# 修改扫码管理首页名
cp -rf TVBox/file/index.html tv/app/src/main/assets/*
#sed -i 's/影視/QTM影视/g' tv/app/src/main/assets/index.html
echo '修改扫码管理首页名完成'

# 软件名称修改
sed -i 's/影视/QTM影视/g' tv/app/src/main/res/values-zh-rCN/strings.xml
sed -i 's/影視/QTM影视/g' tv/app/src/main/res/values-zh-rTW/strings.xml
echo '软件名称修改完成'

# 播放源地址
sed -i '/tv.api.config.LiveConfig/a\import com.fongmi.android.tv.bean.Config;' tv/app/src/main/java/com/fongmi/android/tv/App.java   # import添加播放源Config
sed -i '/this.activity = activity/a\        Config.create(0,"https://gitee.com/MINGERTAI/tvbox-json/raw/main/tv/0/0821.json").update();' tv/app/src/main/java/com/fongmi/android/tv/App.java   # 默认点播配置
echo '添加默认点播配置完成'
sed -i '/默认点播配置/a\        Config.create(1,"https://gitee.com/MINGERTAI/tvbox-json/raw/main/tv/0/0821.json").update();' tv/app/src/main/java/com/fongmi/android/tv/App.java   # 默认直播配置
echo '添加默认直播配置完成'

#图标修改
cp -f TVBox/img/01/ic_launcher.png tv/app/src/main/res/mipmap-hdpi/ic_launcher.png
cp -f TVBox/img/01/ic_launcher_foreground.png tv/app/src/main/res/mipmap-hdpi/ic_launcher_foreground.png
cp -f TVBox/img/02/ic_launcher.png tv/app/src/main/res/mipmap-xhdpi/ic_launcher.png
cp -f TVBox/img/02/ic_launcher_foreground.png tv/app/src/main/res/mipmap-xhdpi/ic_launcher_foreground.png
cp -f TVBox/img/03/ic_launcher.png tv/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
cp -f TVBox/img/03/ic_launcher_foreground.png tv/app/src/main/res/mipmap-xxhdpi/ic_launcher_foreground.png    # 用于手机必须把03改成00替换mipmap-xxhdpi
cp -f TVBox/img/04/ic_launcher.png tv/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
cp -f TVBox/img/04/ic_launcher_foreground.png tv/app/src/main/res/mipmap-xxxhdpi/ic_launcher_foreground.png
cp -f TVBox/img/00/favicon.ico tv/app/src/main/assets/favicon.ico
cp -f TVBox/img/00/ic_banner.png tv/app/src/leanback/res/drawable/ic_banner.png
cp -f TVBox/img/00/ic_logo.png tv/app/src/main/res/drawable-nodpi/ic_logo.png
echo '更换apk logo完成'

# 给apk签名
touch ./ApkSign.sh
cat << 'EOF' > ./ApkSign.sh
#!/bin/bash
echo '给APP签名'
signingConfigs='ICAgIHNpZ25pbmdDb25maWdzIHtcCiAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICBteUNvbmZpZyB7XAogICAgICAgICAgICAgICAgc3RvcmVGaWxlIGZpbGUoUkVMRUFTRV9TVE9SRV9GSUxFKVwKICAgICAgICAgICAgICAgIHN0b3JlUGFzc3dvcmQgUkVMRUFTRV9TVE9SRV9QQVNTV09SRFwKICAgICAgICAgICAgICAgIGtleUFsaWFzIFJFTEVBU0VfS0VZX0FMSUFTXAogICAgICAgICAgICAgICAga2V5UGFzc3dvcmQgUkVMRUFTRV9LRVlfUEFTU1dPUkRcCiAgICAgICAgICAgICAgICB2MVNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICB2MlNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICBlbmFibGVWM1NpZ25pbmcgPSB0cnVlXAogICAgICAgICAgICAgICAgZW5hYmxlVjRTaWduaW5nID0gdHJ1ZVwKICAgICAgICAgICAgfVwKICAgICAgICB9XAogICAgfVwKXA=='
signingConfig='ICAgICAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICAgICAgc2lnbmluZ0NvbmZpZyBzaWduaW5nQ29uZmlncy5teUNvbmZpZ1wKICAgICAgICAgICAgfVwK'
signingConfigs="$(echo "$signingConfigs" |base64 -d )"
signingConfig="$(echo "$signingConfig" |base64 -d )"
sed -i -e "/defaultConfig {/i\\$signingConfigs " -e "/debug {/a\\$signingConfig " -e "/release {/a\\$signingConfig "  tv/app/build.gradle
cp -f TVBox/TVBoxOSC.jks  tv/app/TVBoxOSC.jks
sed -i '$a\RELEASE_STORE_FILE=./TVBoxOSC.jks'      tv/gradle.properties
sed -i '$a\RELEASE_KEY_ALIAS=tv'             tv/gradle.properties
sed -i '$a\RELEASE_STORE_PASSWORD=tv'        tv/gradle.properties
sed -i '$a\RELEASE_KEY_PASSWORD=tv'          tv/gradle.properties
echo '给APP签名 完成'
EOF
chmod +x ./ApkSign.sh
