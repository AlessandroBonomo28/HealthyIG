#!/bin/bash

################################################################################
# Description: Replaces Instagram feed endpoints
# Author: breakthescroll.com
################################################################################

# Get the script name
script_name=$(basename "$0")

# Directory of the decompiled app
target_directory="."

# Define the replacements
declare -A replacements

###############################################################################
########### Uncomment / Comment to Add / Remove resources endpoints ###########
###############################################################################

replacements["\"discover/topical_explore/\""]="\"\""

### Feed main screen
replacements["feed/timeline/\""]="\""

### Feed stories (CAN still upload stories)
# replacements["\"feed/reels_tray/\""]="\"\""

### Reels
replacements["\"clips/discover/\""]="\"\""
replacements["\"discover/explore_clips/\""]="\"\""
replacements["\"clips/discover/stream/\""]="\"\""
#replacements["\"clips/\""]="\"\""
replacements["\"clips/suggested_template\""]="\"\""
replacements["\"clips/trend/\""]="\"\""
#replacements["\"clips/items/\""]="\"\""
replacements["\"discover/discover_similar_clips/\""]="\"\""
replacements["\"/suggested_content/\""]="\"\""
#replacements["\"clips/item/\""]="\"\""
replacements["\"clips/home/\""]="\"\""
replacements["\"clips/chaining/\""]="\"\""
replacements["\"clips/recommended_label/\""]="\"\""
#replacements["\"clips/stream_clips_pivot_page/\""]="\"\""
#replacements["\"clips/risu_medias/\""]="\"\""
#replacements["\"clips_media_ids\""]="\"\""
#replacements["\"/clips\""]="\"\""
replacements["\"/clips_media_feed/\""]="\"\""

###############################################################################
###############################################################################
###############################################################################

echo "Breaking endpoints... This can take a few minutes"

# Collect files (excluding this script and .apk files)
mapfile -t files < <(find "$target_directory" -type f ! -name "$script_name" ! -name "*.apk")
file_count=${#files[@]}

# Create a temporary sed script file to store all replacements (batch processing)
sed_script=$(mktemp)
for old in "${!replacements[@]}"; do
    new="${replacements[$old]}"
    echo "s|$old|$new|g" >> "$sed_script"
done

# Check if tqdm is installed for progress tracking
if command -v tqdm &> /dev/null; then
    echo "Processing $file_count files with tqdm progress..."
    # Use tqdm for progress and xargs for parallel execution
    printf "%s\n" "${files[@]}" | tqdm --total=$file_count --desc "Replacing Endpoints" | xargs -I {} sed -i -f "$sed_script" "{}"
else
    echo "tqdm not installed. Running without progress bar."
    # Process files without tqdm
    xargs -a <(printf "%s\n" "${files[@]}") -I {} sed -i -f "$sed_script" "{}"
fi

# Clean up temporary sed script
rm "$sed_script"

echo "Success: Endpoints broken!"
