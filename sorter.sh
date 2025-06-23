#!/bin/bash

echo "Input Directory Path: "
read -r FOLDER
echo "Accessing $FOLDER ..."

if [[ -d "$FOLDER" ]]; then
	echo "$FOLDER was Found"
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

	echo "$FILETOTAL Files Accessed. $IMGTOTAL images moved. $DOCTOTAL documents moved."
	echo "$REMAINING Remaining"
	
else
	echo "Could not Locate $FOLDER"
	exit 1
fi


