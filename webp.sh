#!/bin/bash
#########################################################################################################
#
# Fast Recursive Images to WebP converter
# Customized for ProcessWire CMS/CMF <https://www.processwire.com>
#
# Author: Eelke Feenstra <dev@eelke.net>
# Version: 001
# Based upon: https://github.com/onadrog/bash-webp-converter
#
# Quick & dirty script to add webp versions to all PNG / JPG / JPEG files inside your PW assets folder
#
# 1. Set this script to executable:
#       $ chmod +x convert-webp.sh
#
# 2. Check if cwebp is installed:
#       $ cwebp -version
#    If it is not, install:
#       $ brew install webp
#    Or follow instructions https://developers.google.com/speed/webp/download
#    and change $executable to cwebp's full path
#
# 3. Run the script directly on a folder:
#       $ ./convert-webp.sh /path/to/your/folder
#
#########################################################################################################

#    Configuration

executable="cwebp"    # update this to reflect your installation!
quality=75            # change to desired WebP quality

#########################################################################################################

converted=0
skipped=0

# echo "Entering $1"

for file in $1/*
do
    # name="${file%.*}"

    # echo "FILE: $file"
    # echo "NAME: $name"

    # Skip the folder itself..
    if [ "$file" = "./." ]; then
        # echo "SKIP: $name"
        continue;
    fi

    if [[ $(file --mime-type -b $file.webp) == image/webp ]]; then

        # echo "FOUND: $name.webp, skipping.."
        skipped=$((skipped+1))

    elif [[ $(file --mime-type -b $file) == image/*g ]]; then

        echo "NOT FOUND: $file.webp"

        # newfile(){
        #     echo "$file" | sed -r 's/(\.[a-z0-9]*$)/.webp/'
        # }

        $executable -q $quality "$file" -short -o "$file.webp"
        converted=$((converted+1))
    fi
done

echo "Converted $converted, Skipped $skipped : $1"