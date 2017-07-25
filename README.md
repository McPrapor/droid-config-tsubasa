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
- [x] Sensors (well they should work according to sensorfw status)

Unknown:
- [ ] GSM voice(have broken antenna :P)
- [ ] GSM data(same problem :P)
- [ ] GPS (never worked with any CM, maybe it is only my phone problem?)
- [ ] Power management(WiFi drains battery)
- [ ] FM radio
- [ ] RTC alarms
- [ ] Haptics
- [ ] WLAN hotspot

Doesn't work:
- [ ] Camera
- [ ] Headset
- [ ] Bluetooth(device reboots after pairing)
- [ ] NCF (SFOS doesn't support)
- [ ] LED (works in fact, but wants adding "ro.product.board=MSM8960" and "ro.board.platform=msm8960" to /default.prop)

Use cm13 from this thread https://forum.xda-developers.com/xperia-t-v/v-development/rom-cyanogenmod-13-0-xperia-t3416938 

Build:
```bash
HABUILD_SDK
make -j8 libdroidmedia minimediaservice minisfservice libcameraservice hwcomposer.msm8960 hybris-hal

MerSDK
cd $ANDROID_ROOT
cd $ANDROID_ROOT
rpm/dhd/helpers/pack_source_droidmedia-localbuild.sh
mkdir -p hybris/mw/droidmedia-localbuild/rpm
cp rpm/dhd/helpers/droidmedia-localbuild.spec hybris/mw/droidmedia-localbuild/rpm/droidmedia.spec
mv hybris/mw/droidmedia-0.0.0.tgz hybris/mw/droidmedia-localbuild
rpm/dhd/helpers/build_packages.sh --build=hybris/mw/droidmedia-localbuild

rpm/dhd/helpers/build_packages.sh --droid-hal --mw=https://github.com/sailfishos/gst-droid.git

rpm/dhd/helpers/build_packages.sh --configs
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
  <remove-project name="mer-hybris/android_system_core"/>
  <project name="McPrapor/hybris-boot" path="hybris/hybris-boot" revision="master" />
  <project name="McPrapor/android_system_core" path="system/core" groups="pdk" revision="hybris-13.0" />
  <project name="McPrapor/droid-hal-tsubasa" path="rpm/" revision="master" />
  <project name="McPrapor/droid-config-tsubasa" path="hybris/droid-configs" revision="master" />
  <project name="McPrapor/droid-hal-version-tsubasa" path="hybris/droid-hal-version-tsubasa" revision="master" />
</manifest>
```
Current hybris/droid-configs/rpm/droid-config-tsubasa.spec:
```spec
# These and other macros are documented in
# ../droid-configs-device/droid-configs.inc
%define device tsubasa
%define vendor sony
%define vendor_pretty SONY
%define device_pretty Xperia V
%define dcd_path ./
# Adjust this for your device
%define pixel_ratio 1.25
# We assume most devices will
%define have_modem 1

%define community_adaptation 1

%include droid-configs-device/droid-configs.inc
```
