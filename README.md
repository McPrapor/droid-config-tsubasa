This is attempt to make SailfishOS port for Sony Xperia V (lt25 tsubasa).

!!! NO WARRANTY OR SUPPORT !!!

For now it's just a draft, but anyway it is already possible to build a working image.

What works:
- [x] Display
- [x] Touch
- [x] Audio
- [x] GSM SMS
- [x] WLAN Connect
- [x] Keys +-
- [x] Vibra
- [x] USB net
- [x] USB charge
- [x] Sensors (well they should work according to sensorfw status. Screen rotation works (: )
- [x] Headset
- [x] FM radio(echo 1 > /sys/module/radio_iris_transport/parameters/fmsmd_set - every time before radio use ; /system/bin/fm_qsoc_patches 199217 0 - once on boot; https://github.com/kimmoli/sfos-onyx-issues/issues/36 - toggle loudspeaker to fix pulseaudio routing)
- [x] LED
- [x] GPS (go outdoor and don't forget to enable it in settings (: )

Unknown:
- [ ] GSM voice(broke the antenna, so can't test)
- [ ] GSM data(same problem :P)
- [ ] RTC alarms
- [ ] Haptics(or it's same as touch?)
- [ ] WLAN hotspot
- [ ] Power management(WiFi drains battery or it's simply old? :D)

Doesn't work:
- [ ] Camera
- [ ] Bluetooth(device reboots after pairing)
- [ ] Codecs(local playback is ok, but no picture in browser, only sound)
- [ ] NFC (No support in SailfishOS)

Use cm13 from this thread https://forum.xda-developers.com/xperia-t-v/v-development/rom-cyanogenmod-13-0-xperia-t3416938 

Build:
```bash
HABUILD_SDK
hadk ; cd $ANDROID_ROOT; source build/envsetup.sh; export USE_CCACHE=1 ; breakfast $DEVICE
make -j8 libdroidmedia minimediaservice minisfservice libcameraservice hwcomposer.msm8960 hybris-hal

MerSDK
cd $ANDROID_ROOT
rpm/dhd/helpers/pack_source_droidmedia-localbuild.sh
mkdir -p hybris/mw/droidmedia-localbuild/rpm
cp rpm/dhd/helpers/droidmedia-localbuild.spec hybris/mw/droidmedia-localbuild/rpm/droidmedia.spec
mv hybris/mw/droidmedia-0.0.0.tgz hybris/mw/droidmedia-localbuild
rpm/dhd/helpers/build_packages.sh --build=hybris/mw/droidmedia-localbuild
```
Patch rpm/dhd/helpers/build_packages.sh and continue with normal build process:
```bash
if (grep -q 'PLATFORM_VERSION := 6.' $ANDROID_ROOT/build/core/version_defaults.mk); then
buildmw https://github.com/mlehtima/libhybris.git hardware-fix || die
#buildmw libhybris mm64-rpm || die
else
buildmw libhybris || die
fi
```
```bash
rpm/dhd/helpers/build_packages.sh

rpm/dhd/helpers/build_packages.sh --mw=https://github.com/sailfishos/gst-droid.git

rpm/dhd/helpers/build_packages.sh --configs
```
Or alternatively you can skip this patch and manually copy output hwcomposer.msm8960.so to /system/lib/hw/ after cm13 firmware installation.

Local manifest(may contain some unused repos) .repo/local_manifests/roomservice.xml:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="CyanogenMod/android_device_qcom_common" path="device/qcom/common" remote="github" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_device_qcom_sepolicy" path="device/qcom/sepolicy" revision="stable/cm-13.0-ZNH5Y" />
<!--  <project name="CyanogenMod/android_device_sony_blue-common" path="device/sony/blue-common" revision="stable/cm-13.0-ZNH5Y" /> -->
  <project name="McPrapor/android_device_sony_blue-common" path="device/sony/blue-common" revision="hybris-13.0" /> 
  <project name="CyanogenMod/android_device_sony_common" path="device/sony/common" remote="github" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_device_sony_tsubasa" path="device/sony/tsubasa" remote="github" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_fuse" path="external/fuse" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_ntfs-3g" path="external/ntfs-3g" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_f2fs-tools" path="external/f2fs-tools" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_gptfdisk" path="external/gptfdisk" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_exfat" path="external/exfat" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_libtar" path="external/libtar" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_toybox" path="external/toybox" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_fsck_msdos" path="external/fsck_msdos" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_pigz" path="external/pigz" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_mksh" path="external/mksh" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_external_stlport" path="external/stlport" revision="stable/cm-13.0-ZNH5Y" /> 
  <project name="CyanogenMod/android_external_sony_boringssl-compat" path="external/sony_boringssl-compat" revision="stable/cm-13.0-ZNH5Y" /> 
  <project name="CyanogenMod/android_external_sepolicy" path="external/sepolicy" revision="stable/cm-13.0-ZNH5Y" /> 
  <project name="CyanogenMod/android_external_elfutils" path="external/elfutils" revision="stable/cm-13.0-ZNH5Y" /> 
<!--  <project name="CyanogenMod/android_kernel_sony_msm8x60" path="kernel/sony/msm8x60" revision="stable/cm-13.0-ZNH5Y" /> -->
  <project name="CyanogenMod/android_hardware_sony_DASH" path="hardware/sony/DASH" remote="github" revision="stable/cm-13.0-ZNH5Y" /> 
<!--  <project name="McPrapor/android_hardware_sony_DASH" path="hardware/sony/DASH" remote="github" revision="stable/cm-13.0-ZNH5Y" /> -->
  <project name="CyanogenMod/android_hardware_sony_thermanager" path="hardware/sony/thermanager" revision="stable/cm-13.0-ZNH5Y" />
  <project name="McPrapor/android_kernel_sony_msm8x60" path="kernel/sony/msm8x60" revision="hybris-13.0" /> -->
  <project name="CyanogenMod/android_system_security" path="system/security" revision="stable/cm-13.0-ZNH5Y" /> 
  <project name="CyanogenMod/android_system_vold" path="system/vold" revision="stable/cm-13.0-ZNH5Y" />

  <project name="TheMuppets/proprietary_vendor_sony" path="vendor/sony" revision="stable/cm-13.0-ZNH5Y" />

  <project name="platform/external/scrypt" path="external/scrypt" groups="pdk" remote="aosp" revision="refs/tags/android-6.0.1_r79" />
  <project name="platform/external/libnl" path="external/libnl" groups="pdk" remote="aosp" revision="refs/tags/android-6.0.1_r79" />
  <project name="platform/external/sfntly" path="external/sfntly" remote="aosp" revision="refs/tags/android-6.0.1_r79"/>

  <remove-project name="mer-hybris/hybris-boot"/>
<!--  <remove-project name="mer-hybris/android_system_core"/> -->
  <project name="McPrapor/hybris-boot" path="hybris/hybris-boot" revision="master" />
<!--  <project name="McPrapor/android_system_core" path="system/core" groups="pdk" revision="hybris-13.0" /> -->
  <project name="McPrapor/droid-hal-tsubasa" path="rpm/" revision="master" />
  <project name="McPrapor/droid-config-tsubasa" path="hybris/droid-configs" revision="master" />
  <project name="McPrapor/droid-hal-version-tsubasa" path="hybris/droid-hal-version-tsubasa" revision="master" />
</manifest>
``` 
