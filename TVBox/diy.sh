#!/bin/bash
sudo timedatectl set-timezone Asia/Shanghai
echo "sourceURL=https://github.com/takagen99/Box" >> $GITHUB_ENV 
# echo "tag=$(git log --date=format:'%Y.%m.%d-%H.%M' -1 --pretty=format:%cd)" >> $GITHUB_ENV
# echo "tag=$(date "+%Y年%m月%d日-%H点%M分")" >> $GITHUB_ENV   # 添加编译时间
echo "tag=$(date "+%Y.%m.%d-%H.%M")" >> $GITHUB_ENV   # 添加编译时间
echo "sourceName=T" >> $GITHUB_ENV
echo "diy_TIME=$(date "+%Y.%m.%d")" >> $GITHUB_ENV   # 添加版本号编译时间变量
echo '生成日期完成'

touch ./custom.sh
cat << 'EOF' > ./custom.sh
#!/bin/bash
echo 'crosswalk源，防挂'
if grep -q 'crosswalk' tv/build.gradle; then
sed -i "/crosswalk/a\        maven { url 'https://o0halflife0o.github.io/crosswalk/releases/crosswalk/android/maven2' }" tv/build.gradle
else
sed -i "/jitpack.io/a\        maven { url 'https://o0halflife0o.github.io/crosswalk/releases/crosswalk/android/maven2' }" tv/build.gradle
fi

#echo '更改软件包名使共存'
#sed -i 's/com.github.tvbox.osc.tk/com.github.tvbox.osc.qtm/g' tv/app/build.gradle

# 未测试
#echo '修改为未降前 用于高版本安卓'
#sed -i '/minSdkVersion/d' tv/app/build.gradle
#sed -i '/com.github.tvbox.osc.tk/a\        minSdkVersion 21' tv/app/build.gradle
#sed -i '/targetSdkVersion/d' tv/app/build.gradle
#sed -i '/minSdkVersion/a\        targetSdkVersion 29' tv/app/build.gradle

#sed -i '/minSdk/d' tv/quickjs/build.gradle
#sed -i '/targetSdk/d' tv/quickjs/build.gradle
#sed -i '/defaultConfig/a\        minSdk 21' tv/quickjs/build.gradle
#sed -i '/minSdk/a\        targetSdk 29' tv/quickjs/build.gradle

#echo '版本降低至minSdkVersion 18 targetSdkVersion 26 用于支持安卓4.4'
#sed -i '/minSdkVersion/d' tv/app/build.gradle
#sed -i '/com.github.tvbox.osc.tk/a\        minSdkVersion 18' tv/app/build.gradle
#sed -i '/targetSdkVersion/d' tv/app/build.gradle
#sed -i '/minSdkVersion/a\        targetSdkVersion 26' tv/app/build.gradle

#sed -i '/minSdk/d' tv/quickjs/build.gradle
#sed -i '/targetSdk/d' tv/quickjs/build.gradle
#sed -i '/defaultConfig/a\        minSdk 18' tv/quickjs/build.gradle
#sed -i '/minSdk/a\        targetSdk 26' tv/quickjs/build.gradle

echo '关于-修改'
sed -i '/android:text=/d' tv/app/src/main/res/layout/dialog_about.xml
sed -i '/shadowRadius=/a\        android:text="        本软件只提供聚合展示功能，所有资源来自网上, 软件不参与任何制作, 上传, 储存, 下载等内容. 软件仅供学习参考, 请于安装后24小时内删除。\\n\\n\\n                                                                    QTM 编译"' tv/app/src/main/res/layout/dialog_about.xml

echo '修改远程管理首页名'
sed -i 's/TVBox/QTM影视/g' tv/app/src/main/res/raw/index.html

echo '软件名称修改'
sed -i 's/TVBox/QTM影视/g' tv/app/src/main/res/values-zh/strings.xml
sed -i 's/TVBox/QTM影视/g' tv/app/src/main/res/values/strings.xml

# 播放源地址
echo '添加内置播放源地址'
#sed -i 's#"app_source"><#"app_source">https://www.taihe.life/tv/api.json<#g' tv/app/src/main/res/values-zh/strings.xml
#sed -i 's#"app_source"><#"app_source">https://www.taihe.life/tv/api.json<#g' tv/app/src/main/res/values/strings.xml
sed -i 's#"app_source"><#"app_source">https://gitee.com/MINGERTAI/gao/raw/master/0821.json<#g' tv/app/src/main/res/values-zh/strings.xml
sed -i 's#"app_source"><#"app_source">https://gitee.com/MINGERTAI/gao/raw/master/0821.json<#g' tv/app/src/main/res/values/strings.xml
#sed -i 's#"app_source"><#"app_source">https://cyao.eu.org/files/n.json<#g' tv/app/src/main/res/values-zh/strings.xml
#sed -i 's#"app_source"><#"app_source">https://cyao.eu.org/files/n.json<#g' tv/app/src/main/res/values/strings.xml

#图标修改
cp -f TVBox/img/04/app_icon.png tv/app/src/main/res/drawable/app_icon.png
cp -f TVBox/img/app_banner.png tv/app/src/main/res/drawable/app_banner.png

#背景修改
cp -f TVBox/img/bg/app_bg.png tv/app/src/main/res/drawable/app_bg.png

# 主页UI调整 恢复老版；默认多行显示
#cp TVBox/takagen99/xmljava/fragment_user.xml tv/app/src/main/res/layout/fragment_user.xml

# 整体布局修改
#cp TVBox/takagen99/xmljava/BaseActivity.java tv/app/src/main/java/com/github/tvbox/osc/base/BaseActivity.java 

# 主页增加每日一言/去除部分图标
#cp TVBox/takagen99/xmljava/ApiConfig.java tv/app/src/main/java/com/github/tvbox/osc/api/ApiConfig.java
#cp TVBox/takagen99/xmljava/activity_home.xml tv/app/src/main/res/layout/activity_home.xml
#cp TVBox/takagen99/xmljava/HomeActivity.java tv/app/src/main/java/com/github/tvbox/osc/ui/activity/HomeActivity.java

# 默认设置修改
#cp TVBox/takagen99/xmljava/App.java tv/app/src/main/java/com/github/tvbox/osc/base/App.java 

# 取消首页从通知栏位置布置
#cp TVBox/takagen99/xmljava/BaseActivity.java tv/app/src/main/java/com/github/tvbox/osc/base/BaseActivity.java 

# 直播添加epg112114支持
#cp TVBox/takagen99/xmljava/LivePlayActivity.java tv/app/src/main/java/com/github/tvbox/osc/ui/activity/LivePlayActivity.java

# 搜索改为爱奇艺热词，支持首字母联想
#cp TVBox/takagen99/xmljava/SearchActivity.java tv/app/src/main/java/com/github/tvbox/osc/ui/activity/SearchActivity.java

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
EOF
chmod +x ./custom.sh

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
