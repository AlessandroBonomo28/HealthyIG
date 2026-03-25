## Healthy IG 🌿

<img src="https://github.com/user-attachments/assets/c2b2658c-6cca-4100-bbfb-eba8ffd53ec2" width="350" />

| IG Version | Platform | Status | Version release date |
|------------|----------|--------|--------|
| ig 300.0.0.29.110 apk | arm64-v8a Android 9+ nodpi | ✅ Tested | 2023-09 |
| ig 300.0.0.29.110 apk | armeabi-v7a Android 7+ nodpi | ✅ Tested | 2023-09 |
| ig 300.0.0.29.110 apk | x86 Android 7+ nodpi | ✅ Tested | 2023-09 |
| ig 413.0.0 ipa iOS 🍏 | ipa sideloaded on iOS using [Sidestore](https://sidestore.io/) | ✅ Tested | 2026-01 |

### Disclaimer 
I am deeply AGAINST ANY FORM OF PIRACY!
this is aimed at showing how to use apktool on your own.
I repeat, NO PIRACY!
the original author of `script.sh` is [breakthescroll.com](https://breakthescroll.com/).

- **The older the ig version, the higher the risk of missing official instagram security updates**
### Mission 🌿
**The mission** is to **prevent scrolling and empower the user** since Meta doesn't allow you to deactivate reels.
If you want to **contribute** just spread the word or make a pull request following the **contribution guidelines** at the end of the page.
### Features

HealthyIG is a modified version of instagram that **BLOCKS** all the toxic instagram features like
> Checkout youtube video for Android 📹: https://www.youtube.com/watch?v=i3DQbfRWN9s

- reels
- home page
- reel chaining 
- explore section

Healthy IG prevents doomscrolling behaviour and **ALLOWS** you to use all of the other
instagram features like

- view your friend's stories
- navigate to profiles via explore search bar
- view profiles
- text your friends
- view the reels that your friend sends you

# Android section 

The app is safe, you can find the base instagram apk from **apkmirror**, decompile it, remove the endpoints
for reel fetching and recompile it. You don't have to trust it, you can build it your own with the instructions in this repository.

## Requirements for Android
Requires **linux or WSL** detailed guide [here](https://github.com/AlessandroBonomo28/HealthyIG/blob/branch/GUIDE_WSL.md). The following tools are required:

- apktool (install https://apktool.org/docs/install/)
- zipalign (`sudo apt install zipalign -y`)
- apksigner (`sudo apt install apksigner -y`)
- tqdm [optional, for displaying progress] (`sudo pip3 install tqdm`)
- sed xargs (support run the script faster)

- `install.apk` is the patched ig (home, explore, reels deactivated but you can still see your friend's reels)
- `ig.apk` is the copy of `com.instagram.android_version...apk`

**Note**: I found `com.instagram.android_version...apk` on apkmirror. In alternative you can try to [extract it from your phone](https://breakthescroll.com/block-reels-instagram/)

## Build your own apk
- Get instagram apk mirror from [apkmirror](https://www.apkmirror.com/apk/instagram/instagram-instagram/instagram-instagram-300-0-0-29-110-release/) (I suggest you to get a [nodpi](https://www.reddit.com/r/AndroidQuestions/comments/3tjtdg/whats_the_difference_between_downloading_a_nodpi/?rdt=33617) version and checkout your [android phone processor info](https://www.droidviews.com/check-android-phones-processor/) ). For extra security you can put the apk into [virustotal](https://www.virustotal.com/gui/home/upload). **It's important that you do it into a linux machine because windows's filesystem will give you problems**.

```
# copy/rename it to ig.apk
sudo cp com.instagram.android_version...apk ig.apk

# decompile the apk
sudo apktool d -r -f -o ig_plain ig.apk

# break the endpoints with script.sh
sudo chmod +x script.sh
sudo ./script.sh

# recompile the apk
# for the apktool >= 3.0 run: sudo apktool b -f ig_plain -o ig_patched.apk
# run this in case it required more heap space (need to provide more RAM to run): sudo java -Xmx4g -jar /usr/local/bin/apktool.jar b -f ig_plain -o ig_patched.apk
sudo apktool b -r -f ig_plain

sudo cp ig_plain/dist/ig.apk patched.apk

# optimize with zipalign
sudo zipalign -v 4 patched.apk install.apk

# generate keypair (insert password 'foobar', the keygen step is required only the first time)
sudo keytool -genkeypair -alias key0 -keyalg RSA -keysize 4096 -validity 10000 -keystore patched_instagram_key.jks

# sign the apk with 'foobar' as password
sudo echo foobar | apksigner sign --ks ./patched_instagram_key.jks --v1-signing-enabled true --v2-signing-enabled true --v3-signing-enabled false install.apk
```
- now **Uninstall your current instagram**
- copy `install.apk` to your phone and install it

**Note for newer versions**: Newer Android apps use split APKs (e.g. version 408.0.0.51.78 contains `base.apk` and `split_config.xxhdpi.apk`). Follow the guide above for `base.apk`, then additionally sign the split config:
```
echo foobar | apksigner sign --ks patched_instagram_key.jks split_config.xxhdpi.apk
```
Install both using:
```
adb install-multiple install.apk split_config.xxhdpi.apk
```
# iOS section 🍏

The app is safe, you can find the base instagram ipa from **decrypt.day**, you can simply open it with 7z **on linux**, extract the Instagram binary and patch it with Ghidra. You don't have to trust it, you can build it your own with the instructions in this repository.

> Checkout youtube video for iOS 🍏: https://youtu.be/5eCFinSWR5M

## Requirements for iOS
- linux virtual machine (for example kali-linux on vmware) with [Ghidra](https://github.com/NationalSecurityAgency/ghidra) installed
- [Sidestore](https://sidestore.io/) installed and working on your iPhone
- iTunes to transfer the .ipa from the pc to the iPhone

> Setup sidestore app autorefresh: https://www.youtube.com/watch?v=hB2h1H2guEA

## Build your own .ipa

- Get instagram ipa mirror from [decrypt.day instagram](https://decrypt.day/app/id389801252) (choose tested version 413.0.0) . For extra security you can put the apk into [virustotal](https://www.virustotal.com/gui/home/upload). **It's important that you do it into a linux machine because windows's filesystem will give you problems**.
- Open the ipa file with a zip explorer like 7z for linux, find the `/Extensions` folder and delete it (otherwise sidestore will log errors and fail to install).
- Now find the `Instagram` binary and extract it from the ipa.
- Open Ghidra, create a new project and import `Instagram` binary
- Now Ghidra will prompt you to start the analysis. Select ONLY `CF strings` and `ASCII strings` for a faster analysis.
-  Once analysis is complete look for the following strings, click right mouse button, select `Patch Data` and then replace 1 character to break the API endpoint
```
# strings to replace in Ghidra (for example change /clips/discover to /xlips/discover):

/clips/discover/stream/
/clips/ads_discover_sync_flow/
/clips/discover/social/
/clips/discover/
/discover/interest_grid/clips/
/clips/trends_media_feed/
/clips/trend_only/
clips/trending_add_yours_prompts
/discover/chaining/
/discover/topical_explore/
/discover/chaining_experience_contextual_ads/
/feed/timeline
/feed/injected_reels_media/
```
- After patching the strings, go to `Export/Export Program`, select `Original file`, name it Instagram and export it.
- Once done exporting, open again the .ipa file with a zip explorer and replace the old `Instagram` binary with the patched one.
- Now the new .ipa is ready to be transfered to your iPhone using iTunes.
- Once the .ipa is on your iPhone, open Sidestore, go to the App section, click on the `+` button and select the ipa.
- You will be prompted with a request that asks if you want to keep the Extensions. It's preferred to choose `Remove Extensions`.
- Wait for install, open it, login and you are done!

### Issue with iOS ⚠️

When you exit the app and swipe up to free the RAM, all data gets wiped and you lose your cached data and login session. This is an annoying problem, if you have a solution feel free to open a PR or create a discussion on how to solve the problem. For now you have to be patient and wait a bit every time you re-open the app. You don't have to reinsert the password to login because it's saved on device but it's still annoying or you are forced to keep the app in RAM. [Issue here](https://github.com/AlessandroBonomo28/HealthyIG/issues/7)

# 🛠️ Contribution Guidelines

## 🚀 Best Practices
- Avoid overengineering `script.sh`.
- Minimize changes to `README.md` unless absolutely necessary.
- If you find alternative methods document it into a different `yourfile.md`.
## 🎯 Preferred Contributions
| Type | Description |
|------|------------|
| ✅ **Markdown and guidelines corrections** | Well documented answers to common problems or correction to existing documentation |
| ✅ **Test on AltStore** | test the iOS solution on alt store |
| ✅ **Improve the iOS method** | automate the process with a script instead of manual patching with Ghidra |
| ✅ **Solving the logout problem on iOS** | on iOS, when you swipe up and close the app, you lose the session and you have to login again if you re-open it |
| ✅ **Discovering New API Routes** | Methods to extract routes from a decompiled APK.<br>📌 **Highly requested**: a way to get an Instagram version with an **active feed**, without "For You" suggestions and ads. |

## ❌ Things to Avoid
- ❌ Do not add untested or unstable features.
- ❌ Avoid unnecessary modifications that drastically change existing code.

# Helpful resources
* Checkout [troubleshoot guide](TROUBLESHOOT.md), you may find the solution to your problem
* Healthy IG [docker version](https://github.com/FedericoCalzoni/healthyig_docker)
* [Block reels on Instagram – Geek approach by breakthescroll.com](https://breakthescroll.com/block-reels-instagram/)
* [Decompile, Recompile, and Sign APKs by Example](https://umatechnology.org/decompile-recompile-and-sign-apks-by-example/)
* [Instagram APKs on APKMirror](https://www.apkmirror.com/apk/instagram/)
* [Instagram ipa mirrors on decrypt.day](https://decrypt.day)
* To discover new endpoints try [ssl pinning bypass](https://github.com/Eltion/Instagram-SSL-Pinning-Bypass) or [burp](https://github.com/Nerixyz/BurpInstaTools). You can also use [JADX](https://github.com/skylot/jadx) or [Ghidra](https://github.com/NationalSecurityAgency/ghidra) to reverse engineer.
### Similar projects
* [SC insta](https://github.com/SoCuul/SCInsta)
* [DFinstagram - alternative ig version](https://www.distractionfreeapps.com/)
* many more
# Donate 🎁
If this improves your life you can [buy me a coffee☕](https://buymeacoffee.com/servizibon0) With your support, I can continue to provide valuable programming tutorials and insights

![ggJxiFC4fys-HD](https://github.com/user-attachments/assets/0ff89cc0-c1f8-4356-a0bc-23d594b99df2)

