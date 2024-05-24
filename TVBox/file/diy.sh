#!/bin/bash

#echo '更改软件包名使共存'
#sed -i 's/com.github.tvbox.osc.tk/com.github.tvbox.osc.qtm/g' TVBoxOSC/app/build.gradle

# 软件名称修改
sed -i 's/影视/QTM影视/g' app/src/main/res/values-zh-rCN/strings.xml
sed -i 's/影視/QTM影视/g' app/src/main/res/values-zh-rTW/strings.xml
echo '软件名称修改完成'

# 添加播放源
sed -i '/tv.api.config.LiveConfig/a\import com.fongmi.android.tv.bean.Config;' app/src/main/java/com/fongmi/android/tv/App.java   # import添加播放源Config
sed -i '/this.activity = activity/a\        Config.create(0,"https://gitee.com/MINGERTAI/tvbox-json/raw/main/tv/0/0821.json").update();' app/src/main/java/com/fongmi/android/tv/App.java   # 默认点播配置
echo '添加默认点播配置完成'
sed -i '/默认点播配置/a\        Config.create(1,"https://gitee.com/MINGERTAI/tvbox-json/raw/main/tv/0/0821.json").update();' app/src/main/java/com/fongmi/android/tv/App.java   # 默认直播配置
echo '添加默认直播配置完成'

# 更改APK LOGO
cp -rf ${{ github.workspace }}/code/TVBox/img/01/ic_launcher.png app/src/main/res/mipmap-hdpi/ic_launcher.png
cp -rf ${{ github.workspace }}/code/TVBox/img/01/ic_launcher_foreground.png app/src/main/res/mipmap-hdpi/ic_launcher_foreground.png
cp -rf ${{ github.workspace }}/code/TVBox/img/02/ic_launcher.png app/src/main/res/mipmap-xhdpi/ic_launcher.png
cp -rf ${{ github.workspace }}/code/TVBox/img/02/ic_launcher_foreground.png app/src/main/res/mipmap-xhdpi/ic_launcher_foreground.png
cp -rf ${{ github.workspace }}/code/TVBox/img/03/ic_launcher.png app/src/main/res/mipmap-xxhdpi/ic_launcher.png
cp -rf ${{ github.workspace }}/code/TVBox/img/03/ic_launcher_foreground.png app/src/main/res/mipmap-xxhdpi/ic_launcher_foreground.png    # 用于手机必须把03改成00替换mipmap-xxhdpi
cp -rf ${{ github.workspace }}/code/TVBox/img/04/ic_launcher.png app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
cp -rf ${{ github.workspace }}/code/TVBox/img/04/ic_launcher_foreground.png app/src/main/res/mipmap-xxxhdpi/ic_launcher_foreground.png
cp -rf ${{ github.workspace }}/code/TVBox/img/00/favicon.ico app/src/main/assets/favicon.ico
cp -rf ${{ github.workspace }}/code/TVBox/img/00/ic_banner.png app/src/leanback/res/drawable/ic_banner.png
cp -rf ${{ github.workspace }}/code/TVBox/img/00/ic_logo.png app/src/main/res/drawable-nodpi/ic_logo.png
echo '修改APK LOGO完成'

# 更改扫码管理页
cp -rf ${{ github.workspace }}/code/TVBox/file/index.html app/src/main/assets/index.html
# sed -i 's/影視/QTM影视/g' app/src/main/assets/index.html
echo '修改远程管理首页名完成'
