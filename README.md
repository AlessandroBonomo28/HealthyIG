## Healthy IG 🌿

<img src="https://github.com/user-attachments/assets/c2b2658c-6cca-4100-bbfb-eba8ffd53ec2" width="350" />

| IG Version | Platform | Status | Version release date |
|------------|----------|--------|--------|
| ig 300.0.0.29.110 | arm64-v8a Android 9+ nodpi | ✅ Tested | 2023-09 |
| ig 300.0.0.29.110 | armeabi-v7a Android 7+ nodpi | ✅ Tested | 2023-09 |
| ig 300.0.0.29.110 | x86 Android 7+ nodpi | ✅ Tested | 2023-09 |
| ig for IOS | iOS .ipa sideload | ❌ Need help | - |

### Disclaimer 
I am deeply AGAINST ANY FORM OF PIRACY!
this is aimed at showing how to use apktool on your own.
I repeat, NO PIRACY!
the original author of `script.sh` is [breakthescroll.com](https://breakthescroll.com/).

- **The older the ig version, the higher the risk of missing official instagram security updates**
### Mission 🌿
**The mission** is is to **prevent scrolling and empower the user** since Meta doesn't allow you to deactivate reels.
If you want to **contribute** just spread the word or make a pull request following the **contribution guidelines** at the end of the page.
### Features

HealthyIG is a modified version of instagram that **BLOCKS** all the toxic instagram features like
> Checkout youtube video 📹: https://www.youtube.com/watch?v=i3DQbfRWN9s

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

The app is safe, I installed the base instagram apk from **apkmirror**, decompiled it, removed the endpoints
for reel fetching and recompiled it. If you don't trust my `install.apk`, you can build it your own with the instructions in this repository.

## Requirements
Requires **linux** with the following tools:

- apktool (install https://apktool.org/docs/install/)
- zipalign (`sudo apt install zipalign -y`)
- apksigner (`sudo apt install apksigner -y`)
- tqdm [optional, for displaying progress] (`sudo pip3 install tqdm`)

- `install.apk` is the patched ig (home, explore, reels deactivated but you can still see your friend's reels)
- `ig.apk` is the copy of `com.instagram.android_version...apk`

**Note**: I found `com.instagram.android_version...apk` on apkmirror. In alternative you can try to [extract it from your phone](https://breakthescroll.com/block-reels-instagram/)

## Build your own apk
- get instagram apk mirror from here https://www.apkmirror.com/apk/instagram/instagram-instagram/instagram-instagram-300-0-0-29-110-release/ (I suggest you to get a [nodpi](https://www.reddit.com/r/AndroidQuestions/comments/3tjtdg/whats_the_difference_between_downloading_a_nodpi/?rdt=33617) version and checkout your [android phone processor info](https://www.droidviews.com/check-android-phones-processor/) )

```
# copy/rename it to ig.apk
sudo cp com.instagram.android_version...apk ig.apk

# decompile the apk
sudo apktool d -r -f -o ig_plain ig.apk

# break the endpoints with script.sh
sudo chmod +x script.sh
sudo ./script.sh

# recompile the apk
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

# 🛠️ Contribution Guidelines

## 🚀 Best Practices
- Avoid overengineering `script.sh`.
- Minimize changes to `README.md` unless absolutely necessary.
- If you find alternative methods document it into a different `yourfile.md`.
## 🎯 Preferred Contributions
| Type | Description |
|------|------------|
| ✅ **iOS solutons** | Solutions for iOS users, particularly sideloading `.ipa` files with detailed instructions. |
| ✅ **Android new solutions** | Alternative methods for decompiling/sideloading on Android should be documented in separate `.md` files. |
| ✅ **Discovering New API Routes** | Methods to extract routes from a decompiled APK.<br>📌 **Highly requested**: a way to get an Instagram version with an **active feed**, without "For You" suggestions and ads. |

## ❌ Things to Avoid
- ❌ Do not add untested or unstable features.
- ❌ Avoid unnecessary modifications that drastically change existing code.

# Helpful resources
* Checkout [troubleshoot guide](TROUBLESHOOT.md), you may find the solution to your problem 
* [Block reels on Instagram – Geek approach by breakthescroll.com](https://breakthescroll.com/block-reels-instagram/)
* [Decompile, Recompile, and Sign APKs by Example](https://umatechnology.org/decompile-recompile-and-sign-apks-by-example/)
* [Instagram APKs on APKMirror](https://www.apkmirror.com/apk/instagram/)
* To discover new endpoints try [ssl pinning bypass](https://github.com/Eltion/Instagram-SSL-Pinning-Bypass) or [burp](https://github.com/Nerixyz/BurpInstaTools). You can also manually decompile and search using `grep` command
### Similar projects
* [Instander - alternative ig version](https://instandersapp.com/)
* [DFinstagram - alternative ig version](https://www.distractionfreeapps.com/)
* many more
# Donate 🎁
If this improves your life you can [buy me a coffe☕](https://buymeacoffee.com/servizibon0) With your support, I can continue to provide valuable programming tutorials and insights

![ggJxiFC4fys-HD](https://github.com/user-attachments/assets/0ff89cc0-c1f8-4356-a0bc-23d594b99df2)

