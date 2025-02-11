@ECHO off
title SausageMod (codename: BlackOutBlues) for Allwinner based tablets
COLOR 1B

:start
cls
@echo off
echo Make sure to enable USB Debugging on the tablet
echo - Settings -) Applications -) Development -) USB debugging (checkmark)
echo THIS SCRIPT WAS DESIGNED todo a lot of things, but has been tested on 
echo many Allwinner A10 tablets. This script may void your warranty, 
echo and may cause issues with your device, so choose Q, q or 9 if you are weary.  
echo Sausage for Dummies--in this order option 4, 5, reset device to factory 
echo settings, and then option 6 to sideload apps.  
echo ...........................................................................
echo 1. Check Tablet Connection..............7. Disable Services to extend battery 
echo 2. Check Root Capable...................8. Re-Enable All Services 
echo 3. Run ROOT Script (experimental).......9.Quit (9, Q, or q)
echo 4. Remove non-english or problematic....Additional Options
echo    apps from default ROM (permanent)....10. Change boot animation
echo 5. Sausagemod V4.091.0 for A1X ICS......(Options10, 10.1, 10.2, 10.3, 10.4)
echo    tablets 5 (Express), 5.1(FullFlavor),11. Reboot Device
echo    5.elf (Ainol Elf 1024x768),(5.P85)...12. Backup some files (12 and 12.1)
echo    5.cm (CM 10 devices), 5.jb (MOMO JB).13. Flash ClockworkMod for ICS only
echo    ALL CHANGES ABOVE  ARE PERMANENT, AND REQUIRE ROM UPGRADE TO BE UNDONE!
echo 6. Side loader--install apks you have in the 
echo    Sausage\install directory.  Do this to load apps quickly.
echo To clean the cache just enter the word cache in the menu below!
echo USE OF THIS SCRIPT, WITHOUT CONSENT, FOR PROFIT IS PROHIBITED!!!!!!!!!!!!!!
set /p choice=Choose Option (1 thru 13.1 OR Q TO QUIT): 

if %choice%==1 goto check
if %choice%==2 goto verify
if %choice%==3 goto root
if %choice%==5 goto express
if %choice%==5.1 goto sausage
if %choice%==5.elf goto elf
if %choice%==5.bird goto elf
if %choice%==5.p85 goto p85
if %choice%==5.cm goto cyanogen
if %choice%==5.jb goto jellybean
if %choice%==4 goto removeapps
if %choice%==6 goto bonusapps
if %choice%==7 goto disable
if %choice%==8 goto enable
if %choice%==Q goto quit
if %choice%==q goto quit
if %choice%==9 goto quit
if %choice%==cleancache goto cache
if %choice%==10 goto mangle
if %choice%==10.1 goto mangle1
if %choice%==10.2 goto mangle2
if %choice%==10.3 goto mangle3
if %choice%==10.4 goto mangle4
if %choice%==11 goto restart1
if %choice%==12 goto backup
if %choice%==12.1 goto report
if %choice%==13 goto clockworkics

:check
cls
echo Running Connection Test
echo  - Make sure you have only one device listed. (EX: 0123456789ABCDEF)
echo '
adb devices
echo Done.
pause
goto start

:verify
cls
echo Verifying ADB can access ROOT
adb root
echo **********************************************************
echo If you see: "adbd cannot run as root in production builds"
echo  - this script WILL NOT work
echo If you see: "restarting adbd as root"
echo  - proceed to option 3
echo If you see: "adbd is already running as root"
echo  - proceed to option 3
echo **********************************************************
echo WE'RE DONE!
pause
goto start

:root
cls
echo Running ROOT Script 
adb root
adb remount
echo Installing Superuser.apk
adb install root/app/Superuser.apk
ping www.google.com
adb reboot
adb wait-for-device
ECHO OFF
ping www.google.com
CLS
ECHO PLEASE WAIT FOR TABLET TO RESTART BEFORE PRESSING ANY KEY
PAUSE
adb root
adb remount
echo Device has restarted?
pause
echo Installing Root Checker
adb install root/app/com.joeykrim.rootcheck.apk
ping www.google.com
adb reboot
adb wait-for-device
ping www.google.com
CLS
ECHO PLEASE WAIT FOR TABLET TO RESTART BEFORE PRESSING ANY KEY
PAUSE
adb root
adb remount
echo Device has restartedecho Installing Busybox
adb install root/app/stericson.busybox.apk
ping www.google.com
adb reboot
adb wait-for-device
ping www.google.com
CLS
ECHO PLEASE WAIT FOR TABLET TO RESTART BEFORE PRESSING ANY KEY
PAUSE
adb root
adb remount
echo Device has restarted 
adb shell mv /system/bin/su /system/bin/su.old
adb shell ln -s /system/xbin/su /system/bin/su
echo '
echo Done.
pause
goto start

:disable
cls
echo Logging in as ROOT User 
adb root
adb remount
echo '
echo Disabling Provision.apk
adb shell mv /system/app/Provision.apk /system/app/!OLDProvision.apk.old
echo Disabling TelephonyProvider.apk
adb shell mv /system/app/TelephonyProvider.apk /system/app/!OLDTelephonyProvider.apk.old
echo Disabling VpnServices.apk
adb shell mv /system/app/VpnServices.apk /system/app/!OLDVpnServices.apk.old
echo Disabling Phone.apk - (Requires Immediate Hard Power Off and Reboot)
adb shell mv /system/app/Phone.apk /system/app/!OLDPhone.apk.old
echo '
echo Done.
pause
goto start

:enable
cls
echo Logging in as ROOT User 
adb root
adb remount
echo '
echo Enabling Provision.apk
adb shell mv /system/app/!OLDProvision.apk.old /system/app/Provision.apk
echo Enabling TelephonyProvider.apk
adb shell mv /system/app/!OLDTelephonyProvider.apk.old /system/app/TelephonyProvider.apk
echo Enabling VpnServices.apk
adb shell mv /system/app/!OLDVpnServices.apk.old /system/app/VpnServices.apk
echo Enabling Phone.apk - (Requires Immediate Hard Power Off and Reboot)
adb shell mv /system/app/!OLDPhone.apk.old /system/app/Phone.apk
echo '
echo Done.
pause
goto start

:sausage
cls
adb root
adb remount
cls
echo FullFlavor SAUSAGEMOD, the A10 Allwinner Gorilla! 
echo You can plug and unplug your USB cable to skip parts...... 
echo If you have a high resolution device, you may want to run 5.elf after this  
echo completes!  All changes are permanent, please read directions on SlateDroid!  
echo Installing modified build.prop and market--PRESS ENTER TO BEGIN
pause
cls
adb push sausage/preinstall.sh /system/bin/preinstall.sh
adb push sausage/build.prop /system/build.prop
echo Upgrading Market
adb shell rm /system/app/vending.apk
adb shell rm /system/app/Vending.apk
echo YOU SHOULD HAVE GOTTEN AT LEAST 1 ERROR
adb push sausage/vending/*.apk /system/app/vending.apk
echo OK next remove some files to make room for those that we will be installing
echo Some errors are not uncommon
pause
cls
adb shell rm /system/app/FileExplore.apk
adb shell rm /system/media/bootanimation.zip
adb shell rm /system/preinstall/free_bizhi.apk
adb shell rm /system/app/PhaseBeam.apk
adb push sausage/boot/bootanimation.zip /system/media/bootanimation.zip
cls
echo Now to modify the (system/app and preinstall) directories
pause
FOR %%n in (sausage/apps/*.apk) DO adb push sausage/apps/%%n /system/app/%%n
FOR %%n in (sausage/*.apk) DO adb push sausage/%%n /system/preinstall/%%n
echo Letting you know you're about to update your permission files......
FOR %%n in (sausage/permissions/*.xml) DO adb push sausage/permissions/%%n /system/etc/permissions/%%n
cls
echo Fixing issues with Gallery sync--removing 2160P Video and installing
echo default Google Gallery application
adb shell rm /system/app/Gallery2.apk
adb shell rm /data/app/Gallery2.apk
adb shell rm /data/app/com.android.gallery3d*.apk
adb shell rm /data/app/com.android.gallery3d-1.apk
echo Updating files...
adb push sausage/fixes/GalleryGoogle.apk /system/app/GalleryGoogle.apk
adb shell chmod 644 /system/app/GalleryGoogle.apk
echo THE CHANGES HAVE BEEN MADE.  TO SEE THE APPS REMOVED AND THE NEW APPS
echo INSTALLED YOU WILL NEED TO RESET YOUR DEVICE TO FACTORY SETTINGS!
echo If you have a higher resolution device please run 5.elf now.  You can use
echo Novo tools to install CWM, or option 13 from the main menu.  
pause
goto start

:express
cls
adb root
adb remount
echo Express SausageMod (fast and compatible) FOR ALLWINNER TABLETS!  
echo These changes are permanent, you should have already BACKED UP!
echo 
pause
cls
echo Installing modified build.prop, updating market, boot animation etc. 
adb push sausage/build.prop /system/build.prop
adb push sausage/boot/bootanimation.zip /system/media/bootanimation.zip
echo Upgrading Market
adb shell rm /system/app/vending.apk
adb shell rm /system/app/Vending.apk
echo YOU SHOULD HAVE GOTTEN AT LEAST 1 ERROR
adb push sausage/vending/*.apk /system/app/vending.apk
adb push sausage/preinstall.sh /system/bin/preinstall.sh
echo Copying over additional files located in permissions folder--PRESS ENTER ONE LAST TIME
pause
FOR %%n in (sausage/permissions/*.xml) DO adb push sausage/permissions/%%n /system/etc/permissions/%%n
echo THE CHANGES HAVE BEEN MADE.  TO SEE THE APPS REMOVED AND THE NEW APPS INSTALLED YOU WILL NEED TO
echo RESET YOUR DEVICE TO FACTORY SETTINGS for all changes to be committed!
pause
goto start

:cyanogen
cls
adb root
adb remount
echo SausageMod for CyanogenMod
echo 
pause
cls
echo Installing modified build.prop
adb push sausage/cm.prop /system/build.prop
 
adb push sausage/apps/Currents_1.5.1.apk /system/app/Currents_1.5.1.apk
adb push sausage/apps/Novotools_v1.0.apk /system/app/Novotools_v1.0.apk
adb shell mount /emmc
adb shell rm /system/app/AdobeFlash*.apk
adb push sausage/CM/AdobeFlashPlayer.apk /emmc/AdobeFlashPlayer.apk
adb shell chmod 644 /emmc/AdobeFlashPlayer.apk
FOR %%n in (sausage/*.apk) DO adb push sausage/%%n /system/app/%%n
echo Upgrading Market
adb shell rm /system/app/vending.apk
adb shell rm /system/app/Vending.apk
echo YOU SHOULD HAVE GOTTEN AT LEAST 1 ERROR
adb push sausage/vending/*.apk /system/app/vending.apk
echo THE CHANGES HAVE BEEN MADE.  A reset is most likely not necessary!  
pause
goto start

:elf
cls
adb root
adb remount
cls
echo This portion of the script has been modified.  You will need to go back and
echo run option 5 or 5.1 first, then apply this script.  So if you haven't already
echo please once this function is complete, go back and run 5 or 5.1 and then re-
echo run this to get the changes for high-res devices.
pause
adb push sausage/elf.prop /system/build.prop
echo THE CHANGES HAVE BEEN MADE.  TO SEE THE APPS REMOVED AND THE NEW APPS INSTALLED YOU WILL NEED TO
echo RESET YOUR DEVICE TO FACTORY SETTINGS for all changes to be committed!
pause
goto start

:p85
cls
adb root
adb remount
cls
echo P85 build.prop installer for 4.0.3 firmware
pause
adb push sausage/p85.prop /system/build.prop
adb shell rm /system/app/Browser.apk
adb push sausage/fixes/Browser.apk /system/app/Browser.apk
echo THE CHANGES HAVE BEEN MADE.  TO SEE THE APPS REMOVED AND THE NEW APPS INSTALLED YOU WILL NEED TO
echo RESET YOUR DEVICE TO FACTORY SETTINGS for all changes to be committed!
pause
goto start

:jellybean
cls
adb root
adb remount
cls
echo Momo9 Jellybean installer for 4.1.1 firmware
pause
adb push sausage/preinstall.sh /system/bin/preinstall.sh
adb push sausage/jb.prop /system/build.prop
adb shell chmod 644 /system/build.prop
adb shell rm /system/app/google.maps.apk
adb shell rm /system/app/QuickSearchBox.apk
adb shell rm /system/app/Gallery2.apk
FOR %%n in (sausage/apps/JB/*.apk) DO adb push sausage/apps/JB/%%n /system/app/%%n
adb push sausage/apps/GenieWidget.apk /system/app/GenieWidget.apk
adb push sausage/JPlayer_2.02.apk /system/app/JPlayer_2.02.apk
adb push sausage/KidMode_4.0.1.apk /system/app/KidMode_4.0.1.apk
adb push sausage/fixes/GalleryGoogle.apk /system/app/GalleryGoogle.apk

echo THE CHANGES HAVE BEEN MADE.  TO SEE THE APPS REMOVED AND THE NEW APPS INSTALLED YOU WILL NEED TO
echo RESET YOUR DEVICE TO FACTORY SETTINGS for all changes to be committed!
pause
goto start

:bonusapps
cls
adb root
adb remount
cls
echo Now installing some additional apps that won't show up when the device is reset to factory settings!
FOR %%n in (sausage/install/*.apk) DO adb install sausage/install/%%n
echo New apps installed!
pause
goto start

:removeapps
cls
adb root
adb remount
echo Removing several non-english preinstalled apps from ROM to make room for others 
adb shell rm /system/app/tonghuashun.apk
adb shell rm /system/app/软件中心2_0.apk
adb shell rm /system/app/KingReaderAppV3.1_MY.apk
adb shell rm /system/app/zdclockployer.apk
adb shell rm /system/app/UC浏览器厂商正式版20120110.apk
adb shell rm /system/app/淘宝.apk
adb shell rm /system/preinstall/水果忍者.apk
adb shell rm /system/preinstall/xiaoniao.apk
adb shell rm /system/preinstall/appInstaller.apk
adb shell rm /system/preinstall/QQ_for_Pad_v1.9.1.apk
adb shell rm /system/preinstall/shipin.apk
adb shell rm /system/preinstall/水果忍者官方版.apk
adb shell rm /system/preinstall/yinyue.apk
adb shell rm /system/preinstall/公交查询.apk
adb shell rm /system/preinstall/新浪微博.apk
adb shell rm /system/preinstall/正点闹钟.apk
adb shell rm /system/app/BaiDuShuRuFaPAD.apk
adb shell rm /system/app/BaiDuShuRuFaPAD.apk
adb shell rm /system/preinstall/Gfanployer.0.8.2_v2176.apk
adb shell rm /system/app/ESWenJianLiuLanQi.apk
adb shell rm /system/app/ESRenWuGuanLiQi.apk
adb shell rm /system/app/FileExplore.apk
adb shell rm /system/app/GfanMobile.apk
adb shell rm /system/app/HaiZhuoLiuLanQiHD.apk
adb shell rm /system/app/Hi.Q.MP3LuYinJi.apk
adb shell rm /system/app/KuWoYinYueHD.apk
adb shell rm /system/app/KuaiTuLiuLan.apk
adb shell rm /system/app/OuPengLiuLanQi.apk
adb shell rm /system/app/PinyinIME.apk
adb shell rm /system/app/QQ.apk
adb shell rm /system/app/ShuiGuoFenZhe.apk
adb shell rm /system/app/UCBrowser.apk
adb shell rm /system/app/ZuiHouDeFangXianHD.apk
adb shell rm /system/app/OpenWnn.apk
echo removing Teclast P85 Apps
adb shell rm /system/app/Weibo2.5.2.apk
adb shell rm /system/app/teclast_ES_FileExplorer.apk
adb shell rm /system/app/teclast_GoMarket_2.1.apk
adb shell rm /system/app/teclast_QQ.apk
adb shell rm /system/app/teclast_apkmanager_239E.apk
adb shell rm /system/app/teclast_baiduinput.apk
adb shell rm /system/app/teclast_dazhihui.apk
adb shell rm /system/app/teclast_game_xjtf.apk
adb shell rm /system/app/teclast_qiyishipin.apk
adb shell rm /system/app/teclast_zhengdiangongjuxiang.apk
adb shell rm /system/app/teclast_game_dzt.apk
adb shell rm /system/app/teclast_game_mzsg.apk
adb shell rm /system/app/teclast_contacts.apk
adb shell rm /system/app/teclast_map.apk
echo removing Momo11 bird apps
adb shell rm /system/preinstall/QQ音乐.apk
adb shell rm /system/preinstall/shuiguorenzhegaoqingban.apk
adb shell rm /system/preinstall/手机电视Pad版.apk
adb shell rm /system/preinstall/UC浏览器_20120110.apk
adb shell rm /system/preinstall/talkingtom2_free_v1.2.1.apk
adb shell rm /system/preinstall/opda_2.3.0.apk
adb shell rm /system/preinstall/SogouInput_android_2.0_sweb.apk
adb shell rm /system/app/qiyiyingshi_V3.0_mumayi_e3d3e.apk
adb shell rm /system/app/tonghuashunshoujichaogu_V5.32.01.apk
adb shell rm /system/app/MOMO软件中心2_0.apk
adb shell rm /system/app/qiyiyingshi_V3.0_mumayi_e3d3e.apk
adb shell rm /system/app/zhonghuawannianli.apk
adb shell rm /system/app/ucic.apk
adb shell rm /system/app/appInstaller.apk
echo removing Momo9 1.1 apps
adb shell rm /system/app/zhonghuawannianli_ECalendar_V3.2.3_mumayi_3ee39.apk
adb shell rm /system/app/UC_20120110.apk
adb shell rm /system/app/shipin.apk
adb shell rm /system/app/iReaderyueduqi_V1.6.0.0_mumayi_f4b0d.apk
adb shell rm /system/preinstall/4.0新版水果忍者.apk
adb shell rm /system/preinstall/androidoptimizer_1.apk
adb shell rm /system/preinstall/qiyiyingshi_V3.0_mumayi_e3d3e.apk
echo removing Momo9 1.4 apps
adb shell rm /system/preinstall/SogouInput.apk
adb shell rm /system/preinstall/UC浏览器.apk
adb shell rm /system/preinstall/iReaderyueduqi.apk
adb shell rm /system/preinstall/qq_mini_hd_1.7.0.apk
adb shell rm /system/preinstall/zhonghuawannianli.apk
adb shell rm /system/preinstall/愤怒的小鸟完整版.apk
adb shell rm /system/preinstall/软件中心2.1.apk
echo removing Teclast P85 4.0.4 apps
adb shell rm /system/app/Weibo2.8.1.apk
adb shell rm /system/app/iReader_ver_1620.apk
adb shell rm /system/app/teclast_360buy_92DC.apk
adb shell rm /system/app/teclast_QQ.apk
adb shell rm /system/app/teclast_UCBrowser.apk
adb shell rm /system/app/teclast_baiduinput.apk

cls
echo Apps have been removed FOR ICS FIRMWARE!  Press any key to continue!
pause
goto start

:mangle
cls
adb root
adb remount
echo This one will change it to an eye!  You can unplug if you want to....  
pause
adb shell rm /system/media/bootanimation.zip
adb push sausage/boot/bootanimationeye.zip /system/media/bootanimation.zip
cls
echo You've received a mangling!
pause
goto start

:mangle1
cls
adb root
adb remount
echo Prepare to receive a mangling!  Bahahahahahah!
adb shell rm /system/media/bootanimation.zip
adb push sausage/boot/bootanimationICS.zip /system/media/bootanimation.zip
cls
echo You've received a mangling!
pause
goto start

:mangle2
cls
adb root
adb remount
echo This one will change green droid animation! 
pause
adb shell rm /system/media/bootanimation.zip
adb push sausage/boot/greenandroid.zip /system/media/bootanimation.zip
cls
echo You've received a mangling!
pause
goto start

:mangle3
cls
echo This is the typical green android installed with previous mod versions
adb root
adb remount
adb shell rm /system/media/bootanimation.zip
adb push sausage/boot/bootanimation.zip /system/media/bootanimation.zip
pause
cls
echo You've received a mangling!
pause
goto start

:mangle4
cls
adb root
adb remount
adb shell rm /system/media/bootanimation.zip
adb push sausage/boot/SYF.zip /system/media/bootanimation.zip
cls
echo You've received a mangling!
pause
goto start

:restart1
cls
adb root
echo You chose to restart?
pause
adb reboot
cls
echo Your device restarted!
goto start

:cache
cls
adb root
adb remount
@ echo off
echo You chose to clean cache and dalvik!
pause
adb shell rm -r /data/dalvik-cache/*
adb shell rm -r /cache/*
pause
cls
echo Cache and dalvik cleaned!
pause
goto start

:backup
cls
adb root
echo You're about to backup some files
pause
adb pull /system/media/bootanimation.zip backup/bootanimation.zip
adb pull /system/app/SystemUI.apk backup/SystemUI.apk
adb pull /system/framework/framework-res.apk backup/framework-res.apk
adb pull /system/build.prop backup/build.prop
adb pull /default.prop backup/default.prop
adb pull /init.rc backup/init.rc
adb pull /init backup/init
adb pull /system/usr/keylayout backup/keylayout
adb pull /system/bin/preinstall.sh backup/preinstall.sh
adb pull /initlogo.rle backup/initlogo.rle
adb pull /system/app/Browser.apk backup/Browser.apk
cls
echo Files have been backed up, and are located in the backup folder!
pause
goto start

:report
cls
adb root
md backup
date /t >backup/NFO.txt
echo *******getprop results******** >>backup/NFO.txt
adb shell getprop >>backup/NFO.txt
date /t >>backup/NFO.txt
echo *******app directory******** >>backup/NFO.txt
adb shell ls system/app >>backup/NFO.txt
date /t >>backup/NFO.txt
echo *******preinstall directory******** >>backup/NFO.txt
adb shell ls system/preinstall >>backup/NFO.txt
cls
echo REPORT COMPLETED!
pause
goto start

:clockworkics
cls
adb root
adb remount
echo You're about to install ClockwordMod!
pause
adb push sausage/apps/Novotools_v1.0.apk /system/app/Novotools_v1.0.apk
adb push CWMICS/recovery.img /sdcard/recovery.img 
adb shell "cat /sdcard/recovery.img > /dev/block/nandg"
adb shell sync; sync; sync
adb push cwmics/reboot-recovery.sh /system/bin/reboot-recovery.sh
pause
cls
echo ClockworkMod Script Complete, hope it was successful!
goto start

:quit
cls
echo Disconnect the cable from your tablet. THEN RESET YOUR DEVICE (erase TF) IMMEDIATELY! (Hold Down Power Button until HARD power off!)
echo '
echo Props to the slatedroid.com community for much of this information.  
pause
exit