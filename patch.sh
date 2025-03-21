#!/bin/bash

################################################################################
# Description: Replaces Instagram feed endpoints
# Author: breakthescroll.com
################################################################################

# rename the base apk
mv base.apk ig.apk

# decompile the apk
apktool d -r -f -o ig_plain ig.apk

# Get the script name
script_name=$(basename "$0")

# Directory of the decompiled app
target_directory="."

# Uncomment / Comment to Add / Remove resources endpoints
declare -A replacements=(
    ### Search section feed (Does not remove search users funcionality)
    ["\"discover/topical_explore/\""]="\"\""
    ### Feed main screen
    ["feed/timeline/\""]="\""
    ### Feed stories (CAN still upload stories)
    #["\"feed/reels_tray/\""]="\"\""
    ### Reels
    ["\"clips/discover/\""]="\"\""
    ["\"discover/explore_clips/\""]="\"\""
    ["\"clips/discover/stream/\""]="\"\""
    #["\"clips/\""]="\"\""
    ["\"clips/suggested_template\""]="\"\""
    ["\"clips/trend/\""]="\"\""
    #["\"clips/items/\""]="\"\""
    ["\"discover/discover_similar_clips/\""]="\"\""
    ["\"/suggested_content/\""]="\"\""
    #["\"clips/item/\""]="\"\""
    ["\"clips/home/\""]="\"\""
    ["\"clips/chaining/\""]="\"\""
    ["\"clips/recommended_label/\""]="\"\""
    #["\"clips/stream_clips_pivot_page/\""]="\"\""
    #["\"clips/risu_medias/\""]="\"\""
    #["\"clips_media_ids\""]="\"\""
    #["\"/clips\""]="\"\""
    ["\"/clips_media_feed/\""]="\"\""
)

echo "I: Breaking endpoints. This can take a few minutes..."

# escape special characters for sed
escape_for_sed() {
    printf '%s\n' "$1" | sed 's/[&/\]/\\&/g'
}

sed_command=""
for old_endpoint in "${!replacements[@]}"; do
    new_endpoint="${replacements[$old_endpoint]}"
    old_escaped=$(escape_for_sed "$old_endpoint")
    new_escaped=$(escape_for_sed "$new_endpoint")
    sed_command+="s/$old_escaped/$new_escaped/g;"
done

if [[ -n "$sed_command" ]]; then
    find "$target_directory" -type f ! -name "$script_name" ! -name "*.apk" -print0 | xargs -0 -I {} sed -i "${sed_command%?}" "{}"
fi

echo "I: Success: Endpoints broken!"
echo "I: Repackage app!"

# recompile the apk
apktool b -r -f ig_plain
cp ig_plain/dist/ig.apk patched.apk

# optimize with zipalign
zipalign -v 4 patched.apk install.apk

# generate keypair (insert password 'foobar', the keygen step is required only the first time)
keytool -genkeypair -alias key0 -keyalg RSA -keysize 4096 -validity 10000 -keystore patched_instagram_key.jks

# sign the apk with 'foobar' as password
echo foobar | apksigner sign --ks ./patched_instagram_key.jks --v1-signing-enabled true --v2-signing-enabled true --v3-signing-enabled true --v4-signing-enabled true install.apk

echo "I: Finished!"
