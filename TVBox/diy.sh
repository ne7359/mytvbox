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
cp -f TVBox/file/index.html tv/app/src/main/assets/index.html
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

# 主页UI调整 恢复老版；默认多行显示
#cp TVBox/file/xmljava/fragment_user.xml tv/app/src/main/res/layout/fragment_user.xml

# 整体布局修改
#cp TVBox/file/xmljava/BaseActivity.java tv/app/src/main/java/com/github/tvbox/osc/base/BaseActivity.java 

# 主页增加每日一言/去除部分图标
#cp TVBox/file/xmljava/ApiConfig.java tv/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
#cp TVBox/file/xmljava/activity_home.xml tv/app/src/main/res/layout/activity_home.xml
#cp TVBox/file/xmljava/HomeActivity.java tv/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

# 默认设置修改
#cp TVBox/file/xmljava/App.java tv/app/src/main/java/com/github/tvbox/osc/base/App.java 

# 取消首页从通知栏位置布置
#cp TVBox/file/xmljava/BaseActivity.java tv/app/src/main/java/com/github/tvbox/osc/base/BaseActivity.java 

# 直播添加epg112114支持
#cp TVBox/file/xmljava/LivePlayActivity.java tv/app/src/main/java/com/github/tvbox/osc/ui/activity/LivePlayActivity.java

# 搜索改为爱奇艺热词，支持首字母联想
#cp TVBox/file/xmljava/SearchActivity.java tv/app/src/main/java/com/github/tvbox/osc/ui/activity/SearchActivity.java

#长按倍速修改为2
#sed -i 's/3.0f/2.0f/g' tv/app/src/main/java/com/github/tvbox/osc/player/controller/VodController.java

#添加详情页播放列表宽度自适
#sed -i '/import me.jessyan.autosize.utils.AutoSizeUtils;/a\import android.graphics.Rect;\nimport android.graphics.Paint;\nimport android.text.TextPaint;\nimport androidx.annotation.NonNull;\nimport android.graphics.Typeface;\nimport androidx.recyclerview.widget.RecyclerView;' tv/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i '/private View seriesFlagFocus = null;/a\    private V7GridLayoutManager mGridViewLayoutMgr = null;' tv/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i 's/mGridView.setLayoutManager(new V7GridLayoutManager(this.mContext, isBaseOnWidth() ? 6 : 7));/mGridView.setHasFixedSize(false);\n        this.mGridViewLayoutMgr = new V7GridLayoutManager(this.mContext, isBaseOnWidth() ? 6 : 7);\n        mGridView.setLayoutManager(this.mGridViewLayoutMgr);\n/g' tv/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i '/seriesAdapter.setNewData(vodInfo.seriesMap.get(vodInfo.playFlag));/i\        Paint pFont = new Paint();\n        Rect rect = new Rect();\n        List<VodInfo.VodSeries> list = vodInfo.seriesMap.get(vodInfo.playFlag);\n        int w = 1;\n        for(int i =0; i < list.size(); ++i){\n            String name = list.get(i).name;\n            pFont.getTextBounds(name, 0, name.length(), rect);\n            if(w < rect.width()){\n                w = rect.width();\n            }\n        }\n        w += 32;\n        int screenWidth = getWindowManager().getDefaultDisplay().getWidth()\/3;\n        int offset = screenWidth\/w;\n        if(offset <=1) offset =1;\n        if(offset > 6) offset =6;\n        this.mGridViewLayoutMgr.setSpanCount(offset);\n' tv/app/src/main/java/com/github/tvbox/osc/ui/activity/DetailActivity.java
#sed -i 's/FrameLayout/LinearLayout/g' tv/app/src/main/res/layout/item_series.xml
#sed -i 's/width=\"wrap_content\"/width=\"match_parent\"/g' tv/app/src/main/res/layout/item_series.xml
#sed -i 's/@dimen\/vs_190/match_parent/g' tv/app/src/main/res/layout/item_series.xml

# 给apk签名
touch ./ApkSign.sh
cat << 'EOF' > ./ApkSign.sh
#!/bin/bash
echo '给APP签名'
signingConfigs='ICAgIHNpZ25pbmdDb25maWdzIHtcCiAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICBteUNvbmZpZyB7XAogICAgICAgICAgICAgICAgc3RvcmVGaWxlIGZpbGUoUkVMRUFTRV9TVE9SRV9GSUxFKVwKICAgICAgICAgICAgICAgIHN0b3JlUGFzc3dvcmQgUkVMRUFTRV9TVE9SRV9QQVNTV09SRFwKICAgICAgICAgICAgICAgIGtleUFsaWFzIFJFTEVBU0VfS0VZX0FMSUFTXAogICAgICAgICAgICAgICAga2V5UGFzc3dvcmQgUkVMRUFTRV9LRVlfUEFTU1dPUkRcCiAgICAgICAgICAgICAgICB2MVNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICB2MlNpZ25pbmdFbmFibGVkIHRydWVcCiAgICAgICAgICAgICAgICBlbmFibGVWM1NpZ25pbmcgPSB0cnVlXAogICAgICAgICAgICAgICAgZW5hYmxlVjRTaWduaW5nID0gdHJ1ZVwKICAgICAgICAgICAgfVwKICAgICAgICB9XAogICAgfVwKXA=='
signingConfig='ICAgICAgICAgICAgaWYgKHByb2plY3QuaGFzUHJvcGVydHkoIlJFTEVBU0VfU1RPUkVfRklMRSIpKSB7XAogICAgICAgICAgICAgICAgc2lnbmluZ0NvbmZpZyBzaWduaW5nQ29uZmlncy5teUNvbmZpZ1wKICAgICAgICAgICAgfVwK'
signingConfigs="$(echo "$signingConfigs" |base64 -d )"
signingConfig="$(echo "$signingConfig" |base64 -d )"
sed -i -e "/defaultConfig {/i\\$signingConfigs " -e "/debug {/a\\$signingConfig " -e "/release {/a\\$signingConfig " tv/app/build.gradle
cp -f TVBox/TVBoxOSC.jks tv/app/TVBoxOSC.jks
sed -i '$a\RELEASE_STORE_FILE=./TVBoxOSC.jks'     tv/gradle.properties
sed -i '$a\RELEASE_KEY_ALIAS=tv'            tv/gradle.properties
sed -i '$a\RELEASE_STORE_PASSWORD=tv'       tv/gradle.properties
sed -i '$a\RELEASE_KEY_PASSWORD=tv'         tv/gradle.properties
echo '给APP签名 完成'
EOF
chmod +x ./ApkSign.sh
