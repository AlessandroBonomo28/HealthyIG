## Healthy IG
<p align="center">
  <img src="https://github.com/user-attachments/assets/c2b2658c-6cca-4100-bbfb-eba8ffd53ec2" width="350" />
</p>

⚠️ **Get it here**: https://detox.bonomo.cloud ⚠️

### Disclaimer
I am deeply AGAINST ANY FORM OF PIRACY! This is aimed at showing how to use apktool on your own. I repeat, NO PIRACY! The original author of `patch.sh` is [Break The Scroll](https://breakthescroll.com/).

### Features
> 📹 Checkout the YouTube video: https://www.youtube.com/watch?v=i3DQbfRWN9s

HealthyIG is a modified version of the Instagram app that **BLOCKS** all the toxic Instagram features like
* reels
* the home page
* reel chaining
* the explore section

HealthyIG prevents doom-scrolling and **ALLOWS** you to use all of the other Instagram features, like
* view your friend's stories
* navigate to profiles via the search bar
* view profiles
* text your friends
* view the reels that your friend sends you

The app is safe. I installed the base Instagram app from **APKMirror**, decompiled it, removed the endpoints for reel fetching, and recompiled it. If you don't trust my `install.apk`, you can build it yourself with the instructions in this repository.

## Requirements
Requires **Linux** with the following tools:

* [apktool](https://apktool.org/docs/install/)
* zipalign (`sudo apt install zipalign -y`)
* apksigner (`sudo apt install apksigner -y`)

- `install.apk` is a patched version of the Instagram app
- `ig.apk` is the copy of `com.instagram.android_version...apk`

I found `com.instagram.android_version...apk` on APKMirror. As an alternative, you can extract it from your phone.

## Build your own APK
### Get the Instagram APK
You can download the Instagram APK from [APKMirror](https://www.apkmirror.com/apk/instagram/instagram-instagram/instagram-instagram-300-0-0-29-110-release/). Alternatively, you can follow these steps to download to extract the APK from your phone directly:
* Open the Settings app.
* Open the menu `About phone`.
* Click on `Build number` until you get developer option.
* Return to the main menu of the Settings app, and open the developer options.
* Under `Debugging`, activate `USB debugging`.
* Install the Android Debug Bridge on your Linux machine (e.g. `sudo apt-get install adb` on Ubuntu).
* Connect your Android device with your Linux machine.
* Allow USB debugging on your Android device.
* Obtain the path of the Instagram APK by running `adb shell pm path com.instagram.android`.
* Finally, pull the APK by running `adb pull <path>`.

### Run the patch script
```bash
./patch.sh
```
- Now **uninstall the Instagram app**.
- Copy `install.apk` to your phone, and install it.

# Helpful resources
* [Block reels on Instagram – Geek approach](https://breakthescroll.com/block-reels-instagram/)
* [Decompile, Recompile, and Sign APKs by Example](https://umatechnology.org/decompile-recompile-and-sign-apks-by-example/)
* [Download the Instagram APK on APKMirror](https://www.apkmirror.com/apk/instagram/)

# Donate 🎁
If this improves your life, you can [buy me a coffee](https://buymeacoffee.com/servizibon0).

![thumb-1920-1354126-181625882](https://github.com/user-attachments/assets/5fc556f0-c09b-4f3b-8626-3f56a5156e5a)
