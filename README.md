## Healthy IG
<img src="https://github.com/user-attachments/assets/c2b2658c-6cca-4100-bbfb-eba8ffd53ec2" width="350"  />

⚠️ **Get it here**: https://detox.bonomo.cloud ⚠️

### Disclaimer
I am deeply AGAINST ANY FORM OF PIRACY!
this is aimed at showing how to use apktool on your own.
I repeat, NO PIRACY!
the original author of `script.sh` is breakthescroll.com
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

- `install.apk` is the patched ig (home, explore, reels deactivated but you can still see your friend's reels)
- `ig.apk` is the copy of `com.instagram.android_version...apk`

I found `com.instagram.android_version...apk` on apkmirror. In alternative you can try to extract it from your phone

## Build your own apk
- get instagram apk mirror from here https://www.apkmirror.com/apk/instagram/instagram-instagram/instagram-instagram-300-0-0-29-110-release/

```
# copy/rename it to ig.apk
sudo cp com.instagram.android_version...apk ig.apk

# decompile the apk
apktool d -r -f -o ig_plain ig.apk
```

**note** always check after you run `script.sh` that the script doesn't corrupts itself replacing his own '//' characters

```
# break the endpoints with script.sh
sudo chmod +x script.sh
./script.sh

# recompile the apk
apktool b -r -f ig_plain

sudo cp ig_plain/dist/ig.apk patched.apk

# optimize with zipalign
zipalign -v 4 patched.apk install.apk

# generate keypair (insert password 'foobar', the keygen step is required only the first time)
keytool -genkeypair -alias key0 -keyalg RSA -keysize 4096 -validity 10000 -keystore patched_instagram_key.jks

# sign the apk with 'foobar' as password
echo foobar | apksigner sign --ks ./patched_instagram_key.jks --v1-signing-enabled true --v2-signing-enabled true --v3-signing-enabled false install.apk
```
- now **Uninstall your current instagram**
- copy `install.apk` to your phone and install it
# Helpful resources

https://breakthescroll.com/block-reels-instagram/

https://umatechnology.org/decompile-recompile-and-sign-apks-by-example/

https://www.apkmirror.com/apk/instagram/

# Donate 🎁
If this improves your life you can buy me a coffe here: https://buymeacoffee.com/servizibon0

![thumb-1920-1354126-181625882](https://github.com/user-attachments/assets/5fc556f0-c09b-4f3b-8626-3f56a5156e5a)

