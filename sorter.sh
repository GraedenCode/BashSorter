#!/bin/bash

echo "Input Directory Path: "
mkdir -p "logs/"
LOGFILE="logs/sort_$(date +"%Y%m%d_%H%M").log"
exec > >(tee -a "$LOGFILE") 2>&1
read -r FOLDER
echo "======================"
echo "Accessing $FOLDER ..."

if [[ -d "$FOLDER" ]]; then
	echo "$FOLDER was Found"
	echo "======================"
	cd "$FOLDER" || exit
	mkdir -p "images"
	mkdir -p "documents"

	FILETOTAL=0
	IMGTOTAL=0
	DOCTOTAL=0
	for FILE in *; do
		FILETOTAL=$((FILETOTAL + 1))

		if [[ "$FILE" == *.txt ]]; then
			mv "$FILE" "documents/" && ((DOCTOTAL++))
			echo "$FILE Moved to Documents"


		elif [[ "$FILE" == *.jpg ]] || [[ "$FILE" == *.png ]] || [[ "$FILE" == *.jpeg ]]; then
			mv "$FILE" "images/" && ((IMGTOTAL++))
			echo "$FILE Moved to Images"

		fi
		
	done			



	REMAINING=$(($FILETOTAL - $IMGTOTAL - $DOCTOTAL))

	echo "**************************************************"
	echo "$IMGTOTAL images moved. $DOCTOTAL documents moved."
	echo "$FILETOTAL Files Accessed. $REMAINING Remaining. "
        echo "$(date)"
	echo "**************************************************"

else
	echo "Could not Locate $FOLDER"
	echo "======================"

	exit 1
fi


