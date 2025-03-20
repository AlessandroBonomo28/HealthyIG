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

### Search section feed (Does not remove search users funcionality)
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

echo "Breaking endpoints... This can take few minutes"

# Function to escape special characters for sed
escape_string_for_sed() {
    local string="$1"
    string=$(sed 's/[&/\]/\\&/g' <<< "$string")
    echo "$string"
}

# Loop through the keys and values in the array
for old_endpoint in "${!replacements[@]}"; do
    new_endpoint="${replacements[$old_endpoint]}"
    
    # Escape special characters for use in sed
    old_endpoint_escaped=$(escape_string_for_sed "$old_endpoint")
    new_endpoint_escaped=$(escape_string_for_sed "$new_endpoint")


    # Use find and sed to replace the endpoint in all files (Excluding this script)
    find "$target_directory" -type f ! -name "$script_name" ! -name "*.apk" -exec sed -i "s/$old_endpoint_escaped/$new_endpoint_escaped/g" {} +
done

echo "Success: Endpoints broken!"