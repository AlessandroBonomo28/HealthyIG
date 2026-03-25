#!/bin/bash

################################################################################
# Description: Replaces Instagram feed endpoints (Optimized for WSL/Linux)
# Author: Adapted for Hoàng Minh Tâm
################################################################################

script_name=$(basename "$0")
target_directory="."

HAS_TQDM=false
if command -v tqdm &> /dev/null; then
    HAS_TQDM=true
fi

declare -A replacements

# --- Explore & Main Feed ---
replacements["discover/topical_explore/"]=""
replacements["feed/timeline/"]=""

# --- Reels / Clips ---
replacements["clips/discover/"]=""
replacements["clips/discover/social/"]=""
replacements["discover/explore_clips/"]=""
replacements["clips/discover/stream/"]=""
replacements["clips/suggested_template"]=""
replacements["clips/trend/"]=""
replacements["discover/discover_similar_clips/"]=""
replacements["/suggested_content/"]=""
replacements["clips/home/"]=""
replacements["clips/chaining/"]=""
replacements["clips/recommended_label/"]=""
replacements["/clips_media_feed/"]=""

# 1. Create file temp sed script to run batch
sed_script=$(mktemp)
for old in "${!replacements[@]}"; do
    new="${replacements[$old]}"
    echo "s|$old|$new|g" >> "$sed_script"
done

echo "🚀 Đang quét file và phá Endpoints... Đợi tí nhé bro!"

# 2. Count amount file for progress bar (if it has tqdm)
file_list=$(mktemp)
find "$target_directory" -type f ! -name "$script_name" ! -name "*.apk" ! -path "*/.*" > "$file_list"
file_count=$(wc -l < "$file_list")

# 3. Start replacing with parallel processing
if [ "$HAS_TQDM" = true ]; then
    cat "$file_list" | tqdm --total="$file_count" --desc "Processing" --unit "file" | xargs -d '\n' -P 4 -n 20 sed -i -f "$sed_script"
else
    echo "⚠️  tqdm chưa cài (pip3 install tqdm). Đang chạy chế độ thường..."
    cat "$file_list" | xargs -d '\n' -P 4 -n 20 sed -i -f "$sed_script"
fi

# 4. Cleanup temp files
rm "$sed_script"
rm "$file_list"

echo -e "\n✅ Done! All endpoints have been replaced. Enjoy your Instagram experience without those pesky feed endpoints! 🎉"