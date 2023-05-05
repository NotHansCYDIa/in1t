#!/bin/bash

show_help() {
echo "in1t: A simple package manager made in shell"
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -h, --help                 Show this help message"
    echo "  -i [Package]               Install Package"
    echo "  -r, -uninstall [Package]   Uninstalls Installed Package"
    echo "  -c [Package]               Checks if package is available"
    echo "  -C [Package]               Checks if package is installed"
    echo "  -I, --info [Package]       Shows info on package if available"
echo ""

}

while true; do
    case "$1" in
        -h|--help )
            show_help
            exit 0
            ;;
        -i )
            PACKAGE="Packages/$2/"
            FOLDER="Packages/$2"
            PKG="$2"
            DIR=$(pwd)
            if [ ! -d "/usr/local/in1tpkg" ]; then
                CMD=$(grep "Command:" $PACKAGE/info | cut -d ":" -f2-)
                echo "Creating in1tpkg..."
                sudo mkdir /usr/local/in1tpkg
                sudo chown -R "$USER" /usr/local/in1tpkg
            fi
            if [ -d "$FOLDER" ]; then
                if [ -d "/usr/local/in1tpkg/$PKG" ]; then
                    echo "Package: $PKG is already installed."
                else
                    echo "Installing Package..."
                    cp -R "$FOLDER" "/usr/local/in1tpkg"
                    SH=$(cd "/usr/local/in1tpkg/$PKG" && find . -type f -name "*.sh")
                    for file in $SH; do
                        chmod +x "/usr/local/in1tpkg/$PKG/$file"
                        sudo ln -s "/usr/local/in1tpkg/$PKG/$file" "/usr/local/bin/$(basename "$file" .sh)"
                    done
                    echo "Package is installed!"
                    echo "You can run: $CMD"
                fi
            else
                echo "Package not found."
            fi
            exit 0
            ;;
        -r|-uninstall)
            PACKAGE="Packages/$2/"
            PKG="$2"
            if [ -d "/usr/local/in1tpkg/$PKG" ]; then
                echo "Uninstalling Package..."
                SH=$(cd "/usr/local/in1tpkg/$PKG" && find . -type f -name "*.sh")
                for file in $SH; do
                    sudo rm "/usr/local/bin/$(basename "$file" .sh)"
                    rm "/usr/local/in1tpkg/$PKG/$file"
                done
                rm -rf "/usr/local/in1tpkg/$PKG"
                echo "Package is uninstalled!"
            else
                echo "Package is not installed."
            fi
            exit 0
            ;;
        -c)
            PACKAGE="Packages/$2/"
            if [ -d "$PACKAGE" ]; then
                echo "Package $2 is available. You can install by doing: $0 -i $2"
            else
                echo "Package: $2 not available or found."
            fi
            exit 0
            ;;
        -C)
            PKG="$2"
            if [ -d "/usr/local/in1tpkg/$PKG" ]; then
                echo "Package $PKG is already installed."
            else
                echo "Package $PKG is not installed."
            fi
            exit 0
            ;;
        -I|--info)
            PACKAGE="Packages/$2/"
            FOLDER="Packages/$2"
            PKG="$2"
            if [ -d "$PACKAGE" ]; then
                if [ -f "$PACKAGE/info" ]; then
                    DESCRIPTION=$(grep "Description:" $PACKAGE/info | cut -d ":" -f2-)
                    VERSION=$(grep "Version:" $PACKAGE/info | cut -d ":" -f2-)
                    CREATOR=$(grep "Creator:" $PACKAGE/info | cut -d ":" -f2-)
                    BUNDLE=$(grep "Bundle:" $PACKAGE/info | cut -d ":" -f2-)
                    RELEASE=$(grep "Release:" $PACKAGE/info |
                    echo "= $PKG"
                    echo "$DESCRIPTION"
                    echo ""
                    echo "$CREATOR - $BUNDLE $VERSION ~ $RELEASE Release"
                else
                    echo "Info is not available for the package."
                fi
            else
                echo "Package: $2 not available or found."
            fi
            exit 0
            ;;
        *)
            echo "Invalid command: $1"
            show_help
            break
            ;;
    esac
done

