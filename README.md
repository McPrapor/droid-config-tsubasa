This is attempt to make SailfishOS port for Sony Xperia V (lt25 tsubasa). For now it's just a draft, but anyway it is already possible to build an working image.
What works:
+ Display
+ Touch
+ LED
+ Audio
+ GSM SMS
+ WLAN Connect
+ Keys +-
+ Vibra
+ USB net
+ USB charge
Unknown:
? GSM voice(have broken antenna :P)
? GSM data(same problem :P)
? GPS didn't test yet
? Power management(doesn't work or just have old battery?)
? FM radio
? RTC alarms
? Haptics
? WLAN hotspot
Doesn't work:
- Camera
- Bluetooth
- Sensors
- NFS (SFOS doesn't have support)

Local manifest(may contains some unused repos):
`$ cat .repo/local_manifests/roomservice.xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="CyanogenMod/android_device_qcom_common" path="device/qcom/common" remote="github" />
  <project name="CyanogenMod/android_device_qcom_sepolicy" path="device/qcom/sepolicy" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_device_sony_blue-common" path="device/sony/blue-common" revision="stable/cm-13.0-ZNH5Y" />
  <project name="CyanogenMod/android_device_sony_common" path="device/sony/common" remote="github" />
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
  <project name="CyanogenMod/android_hardware_sony_DASH" path="hardware/sony/DASH" remote="github" />
  <project name="CyanogenMod/android_hardware_sony_thermanager" path="hardware/sony/thermanager" revision="stable/cm-13.0-ZNH5Y" />
  <project name="McPrapor/android_kernel_sony_msm8x60" path="kernel/sony/msm8x60" revision="hybris-13.0" /> -->
  <project name="CyanogenMod/android_system_security" path="system/security" revision="stable/cm-13.0-ZNH5Y" /> 
  <project name="CyanogenMod/android_system_vold" path="system/vold" revision="stable/cm-13.0-ZNH5Y" />

  <project name="TheMuppets/proprietary_vendor_sony" path="vendor/sony" revision="stable/cm-13.0-ZNH5Y" />

  <project name="platform/external/scrypt" path="external/scrypt" groups="pdk" remote="aosp" revision="refs/tags/android-6.0.1_r79" />
  <project name="platform/external/libnl" path="external/libnl" groups="pdk" remote="aosp" revision="refs/tags/android-6.0.1_r79" />
  <project name="platform/external/sfntly" path="external/sfntly" remote="aosp" revision="refs/tags/android-6.0.1_r79"/>

  <project name="McPrapor/droid-hal-tsubasa" path="rpm/" revision="master" />
  <project name="McPrapor/droid-config-tsubasa" path="hybris/droid-configs" revision="master" />
  <project name="McPrapor/droid-hal-version-tsubasa" path="hybris/droid-hal-version-tsubasa" revision="master" />
</manifest>`
