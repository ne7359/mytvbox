#!/bin/bash

sed -i '/Updater.get().release().start(this)/d' app/src/mobile/java/com/fongmi/android/tv/ui/activity/MainActivity.java
sed -i '/Updater.get().release().start(this)/d' app/src/leanback/java/com/fongmi/android/tv/ui/activity/HomeActivity.java
rm -rf app/src/leanback/java/com/fongmi/android/tv/Updater.java
rm -rf app/src/mobile/java/com/fongmi/android/tv/Updater.java
echo '删除自动更新完成'

sed -i 's/影视/QTM影视/g' app/src/main/res/values-zh-rCN/strings.xml
sed -i 's/影視/QTM影视/g' app/src/main/res/values-zh-rTW/strings.xml
echo '软件名称修改完成'

cp -rf $GITHUB_WORKSPACE/code/TVBox/file/index.html app/src/main/assets/index.html
#sed -i 's/影視/QTM影视/g' app/src/main/assets/index.html
echo '修改远程管理首页名完成'
          
sed -i '/tv.api.config.LiveConfig/a\import com.fongmi.android.tv.bean.Config;' app/src/main/java/com/fongmi/android/tv/App.java   # import添加播放源Config
sed -i '/this.activity = activity/a\        Config.create(0,"https://gitee.com/MINGERTAI/tvbox-json/raw/main/tv/0/0821.json").update();' app/src/main/java/com/fongmi/android/tv/App.java   # 默认点播配置
echo '添加默认点播配置完成'
sed -i '/默认点播配置/a\        Config.create(1,"https://gitee.com/MINGERTAI/tvbox-json/raw/main/tv/0/0821.json").update();' app/src/main/java/com/fongmi/android/tv/App.java   # 默认直播配置
echo '添加默认直播配置完成'
          
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/01/ic_launcher.png app/src/main/res/mipmap-hdpi/ic_launcher.png
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/01/ic_launcher_foreground.png app/src/main/res/mipmap-hdpi/ic_launcher_foreground.png
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/02/ic_launcher.png app/src/main/res/mipmap-xhdpi/ic_launcher.png
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/02/ic_launcher_foreground.png app/src/main/res/mipmap-xhdpi/ic_launcher_foreground.png
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/03/ic_launcher.png app/src/main/res/mipmap-xxhdpi/ic_launcher.png
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/03/ic_launcher_foreground.png app/src/main/res/mipmap-xxhdpi/ic_launcher_foreground.png    # 用于手机mipmap-xxhdpi
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/04/ic_launcher.png app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/04/ic_launcher_foreground.png app/src/main/res/mipmap-xxxhdpi/ic_launcher_foreground.png
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/00/favicon.ico app/src/main/assets/favicon.ico
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/00/ic_banner.png app/src/leanback/res/drawable/ic_banner.png
cp -rf $GITHUB_WORKSPACE/code/TVBox/img/00/ic_logo.png app/src/main/res/drawable-nodpi/ic_logo.png
echo '修改APK LOGO完成'

signingConfigs='ICAgIHNpZ25pbmdDb25maWdzIHtcCiAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICBteUNvbmZpZyB7XAogICAgICAgICAgICAgICAgc3RvcmVGaWxlIGZpbGUoUkVMRUFTRV9TVE9SRV9GSUxFKVwKICAgICAgICAgICAgICAgIHN0b3JlUGFzc3dvcmQgUkVMRUFTRV9TVE9SRV9QQVNTV09SRFwKICAgICAgICAgICAgICAgIGtleUFsaWFzIFJFTEVBU0VfS0VZX0FMSUFTXAogICAgICAgICAgICAgICAga2V5UGFzc3dvcmQgUkVMRUFTRV9LRVlfUEFTU1dPUkRcCiAgICAgICAgICAgICAgICB2MVNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICB2MlNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICBlbmFibGVWM1NpZ25pbmcgPSB0cnVlXAogICAgICAgICAgICAgICAgZW5hYmxlVjRTaWduaW5nID0gdHJ1ZVwKICAgICAgICAgICAgfVwKICAgICAgICB9XAogICAgfVwKXA=='
signingConfig='ICAgICAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICAgICAgc2lnbmluZ0NvbmZpZyBzaWduaW5nQ29uZmlncy5teUNvbmZpZ1wKICAgICAgICAgICAgfVwK'
signingConfigs="$(echo "$signingConfigs" |base64 -d )"
signingConfig="$(echo "$signingConfig" |base64 -d )"
sed -i -e "/defaultConfig {/i\\$signingConfigs " -e "/debug {/a\\$signingConfig " -e "/release {/a\\$signingConfig " app/build.gradle
cp -f $GITHUB_WORKSPACE/code/TVBox/TVBoxOSC.jks app/TVBoxOSC.jks
sed -i '$a\RELEASE_STORE_FILE=./TVBoxOSC.jks'     ./gradle.properties
sed -i '$a\RELEASE_KEY_ALIAS=TVBoxOSC'            ./gradle.properties
sed -i '$a\RELEASE_STORE_PASSWORD=TVBoxOSC'       ./gradle.properties
sed -i '$a\RELEASE_KEY_PASSWORD=TVBoxOSC'         ./gradle.properties
echo '签名完成'

#添加添加PY支持
touch $GITHUB_WORKSPACE/add-py.sh
cat << 'EOF' > $GITHUB_WORKSPACE/add-py.sh
#!/bin/bash
echo '添加PY支持'
wget --no-check-certificate -qO- "https://raw.githubusercontent.com/UndCover/PyramidStore/main/aar/pyramid-1011.aar" -O app/libs/pyramid.aar
sed -i "/thunder.jar/a\    implementation files('libs@pyramid.aar')" app/build.gradle
sed -i 's#@#\\#g' app/build.gradle
sed -i 's#pyramid#\\pyramid#g' app/build.gradle
echo "" >> app/proguard-rules.pro
echo "#添加PY支持" >> app/proguard-rules.pro
echo "-keep public class com.undcover.freedom.pyramid.** { *; }" >> app/proguard-rules.pro
echo "-dontwarn com.undcover.freedom.pyramid.**" >> app/proguard-rules.pro
echo "-keep public class com.chaquo.python.** { *; }" >> app/proguard-rules.pro
echo "-dontwarn com.chaquo.python.**" >> app/proguard-rules.pro
sed -i '/import com.orhanobut.hawk.Hawk;/a\import com.undcover.freedom.pyramid.PythonLoader;' app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/import com.orhanobut.hawk.Hawk;/a\import com.github.catvod.crawler.SpiderNull;' app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/PlayerHelper.init/a\        PythonLoader.getInstance().setApplication(this);' app/src/main/java/com/github/tvbox/osc/base/App.java
sed -i '/import android.util.Base64;/a\import com.github.catvod.crawler.SpiderNull;' app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/import android.util.Base64;/a\import com.undcover.freedom.pyramid.PythonLoader;' app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/private void parseJson(String apiUrl, String jsonStr)/a\        PythonLoader.getInstance().setConfig(jsonStr);' app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/public Spider getCSP(SourceBean sourceBean)/a\        if (sourceBean.getApi().startsWith(\"py_\")) {\n        try {\n            return PythonLoader.getInstance().getSpider(sourceBean.getKey(), sourceBean.getExt());\n        } catch (Exception e) {\n            e.printStackTrace();\n            return new SpiderNull();\n        }\n    }' app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
sed -i '/public Object\[\] proxyLoca/a\    try {\n        if(param.containsKey(\"api\")){\n            String doStr = param.get(\"do\").toString();\n            if(doStr.equals(\"ck\"))\n                return PythonLoader.getInstance().proxyLocal(\"\",\"\",param);\n            SourceBean sourceBean = ApiConfig.get().getSource(doStr);\n            return PythonLoader.getInstance().proxyLocal(sourceBean.getKey(),sourceBean.getExt(),param);\n        }else{\n            String doStr = param.get(\"do\").toString();\n            if(doStr.equals(\"live\")) return PythonLoader.getInstance().proxyLocal(\"\",\"\",param);\n        }\n    } catch (Exception e) {\n        e.printStackTrace();\n    }\n' app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
echo '添加PY支持完成'
EOF
chmod +x $GITHUB_WORKSPACE/add-py.sh
