#!/bin/sh

case "$1" in
    -mk)
        DIR=$(pwd)
        read -p "Package Name: " NAME
        read -p "Package Description: " DESCRIPTION
        read -p "Package Version e.g. 1.0.0: " VERSION
        read -p "Package Author: " CREATOR
        read -p "Package Type (can be found in in1t github repo wiki): " TYPE
        read -p "Package Bundle e.g. com.example.package: " BUNDLE
        read -p "Main Shell e.g. mypkg (automatically will add .sh): " MAIN
        FILE="$MAIN.sh"
        echo "Package created!"
        mkdir -p "$DIR/$NAME"
        cd "$DIR/$NAME"
        touch "$FILE"
        touch "info"
        echo "
        Description: $DESCRIPTION
        Creator: $CREATOR
        Version: $VERSION
        Release: Stable
        Type: $TYPE
        Bundle: $BUNDLE
        Command: $MAIN" >> "$FILE"
        ;;
    -pkg)
        DIR=$(pwd)
        FOLDER=$(basename "$PWD")
        ZIP="$FOLDER.zip"

        if [ ! -d "$DIR/Packages" ]; then
            mkdir "$DIR/Packages"
        fi

        cd ..
        if [ -d "$FOLDER" ]; then
            zip -r "$ZIP" "$FOLDER"
            mv "$ZIP" "$DIR/Packages/"
            echo "Done creating package!: $DIR/Packages/$ZIP"
        else
            echo "Error: Directory not found"
            exit 1
        fi

        exit 0
        ;;
    *)
        echo "Usage: $0 [OPTIONS]"
        echo "Tutorial:"
        echo "    1. To create your package run: $0 -mk"
        echo "    2. Fill in the info then do NOT change your command field in the info field unless you rename your main sh file."
        echo "    3. After that make sure to cd to your package and run: $0 -pkg"
        echo "    4. And then it should make a Packages folder and the zip file should appear"
        echo "    5. After that go to the in1t repo and scroll down in the readme and click on the link/text (go to this link) then fill out the field and your package should be ready for approval."
        echo "by NotHansCYDIa - 1.0.0"
        echo ""
        exit 0
        ;;
esac
