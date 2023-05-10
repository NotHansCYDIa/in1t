#!/bin/bash

show_help() {
    echo -e "\033[1min1t\033[0m: A simple package manager made in shell"
    echo -e "Usage: $0 [ARGUMENTS]"
    echo "Arguments:"
    echo "  -a, --allpkgs              Shows all packages available"
    echo "  -A, --allinstalled         Shows all installed packages"
    echo "  -c <Package>               Checks if package is available"
    echo "  -C <Package>               Checks if package is installed"
    echo "  -h, --help                 Show this help message"
    echo "  -i <Package>               Install Package"
    echo "  -I, --info <Package>       Shows info on package if available"
    echo "  -r, -uninstall <Package>   Uninstalls Installed Package"
    echo "  -s, --search <String>      Search for packages"
    echo "  -u, --upgrade <Package>    Upgrades an installed package"
    echo "  -v  <Package>              Gets package version"
    echo ""
}

if [ $# -eq 0 ]; then
    echo -e "\033[1min1t\033[0m: A simple package manager made in shell"
    exit 0
fi


while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help )
            show_help
            exit 0
            ;;
        -i )
            PACKAGE=".Packages/$2/"
            FOLDER=".Packages/$2"
            PKG="$2"
            DIR=$(pwd)
            if [ -d "$FOLDER" ]; then
                if [ -d "/usr/local/in1tpkg/$PKG" ]; then
                    echo -e "\033[1;33mPackage: $PKG is already installed.\033[0m"
                else
                    if [ ! -d "/usr/local/in1tpkg" ]; then
                        CMD=$(grep "Command:" "$PACKAGE/info" | cut -d ":" -f2- | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
                        echo -e "\033[1;38;5;208mCreating in1tpkg...\033[0m"
                        sudo mkdir /usr/local/in1tpkg
                        sudo chown -R "$USER" /usr/local/in1tpkg
                    fi
                    echo -e "\033[1;38;5;214mInstalling Package...\033[0m"
                    cp -R "$FOLDER" "/usr/local/in1tpkg"
                    SH=$(cd "/usr/local/in1tpkg/$PKG" && find . -type f -name "*.sh")
                    for file in $SH; do
                        chmod +x "/usr/local/in1tpkg/$PKG/$file"
                        sudo ln -s "/usr/local/in1tpkg/$PKG/$file" "/usr/local/bin/$(basename "$file" .sh)"
                    done
                    CMD=$(grep "Command:" "$PACKAGE/info" | cut -d ":" -f2- | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
                    echo -e "\033[1;32mPackage is installed!\033[0m"
                    echo -e "\033[1;34mYou can run: \033[1m$CMD\033[0m"
                fi
            else
                echo -e "\033[1m\033[31mPackage not found.\033[0m"
            fi
            exit 0
            ;;
        -r|-uninstall)
            PACKAGE=".Packages/$2/"
            PKG="$2"
            if [ -d "/usr/local/in1tpkg/$PKG" ]; then
                echo -e "\033[1;38;5;208mUninstalling Package...\033[0m"
                SH=$(cd "/usr/local/in1tpkg/$PKG" && find . -type f -name "*.sh")
                for file in $SH; do
                    sudo rm -rf "/usr/local/bin/$(basename "$file" .sh)"
                    rm -rf "/usr/local/in1tpkg/$PKG/$file"
                done
                rm -rf "/usr/local/in1tpkg/$PKG"
                echo -e "\033[1m\033[32mPackage is uninstalled!\033[0m"
            else
                echo -e "\033[1;33mPackage is not installed.\033[0m"
            fi
            exit 0
            ;;
        -u|--upgrade)
            PKG="$2"
            PACKAGE=".Packages/$2/"
            FOLDER=".Packages/$2"
            DIR=$(pwd)
            if [ -d "$PACKAGE" ]; then
                if [ -d "/usr/local/in1tpkg/$PKG" ]; then
                    echo -e "\033[1;38;5;208mUpgrading Stage 1 Package...\033[0m"
                    SH=$(cd "/usr/local/in1tpkg/$PKG" && find . -type f -name "*.sh")
                    for file in $SH; do
                        sudo rm -rf "/usr/local/bin/$(basename "$file" .sh)"
                        rm -rf "/usr/local/in1tpkg/$PKG/$file"
                    done
                    rm -rf "/usr/local/in1tpkg/$PKG"
                    echo -e "\033[1m\033[32mStage [1/2]\033[0m"
                    echo -e "\033[1;38;5;214mUgrading Package...\033[0m"
                    cp -R "$FOLDER" "/usr/local/in1tpkg"
                    SH=$(cd "/usr/local/in1tpkg/$PKG" && find . -type f -name "*.sh")
                    for file in $SH; do
                        chmod +x "/usr/local/in1tpkg/$PKG/$file"
                        sudo ln -s "/usr/local/in1tpkg/$PKG/$file" "/usr/local/bin/$(basename "$file" .sh)"
                    done
                    CMD=$(grep "Command:" "$PACKAGE/info" | cut -d ":" -f2- | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
                    echo -e "\033[1;32mPackage upgraded!\033[0m"
                    echo -e "\033[1;34mYou can now run: \033[1m$CMD\033[0m"
                else
                    echo -e "\033[1;33mPackage: $PKG is not installed.\033[0m"
                fi
            else
                echo -e "\033[1m\033[33mPackage: $PKG is not available\033[0m"
            fi
            exit 0
            ;;
        -c)
            PACKAGE=".Packages/$2/"
            if [ -d "$PACKAGE" ]; then
                echo -e "\033[1m\033[32mPackage $2 is available. You can install by doing: $0 -i $2\033[0m"
            else
                echo -e "\033[1m\033[33mPackage is not available/found.\033[0m"
            fi
            exit 0
            ;;
        -C)
            PKG="$2"
            if [ -d "/usr/local/in1tpkg/$PKG" ]; then
                echo -e "\033[1m\033[1m\033[32mPackage: $PKG is already installed.\033[1m\033[1m\033[32m"
            else
                echo -e "\033[1;33mPackage: $PKG is not installed.\033[0m"
            fi
            exit 0
            ;;
        -I|--info)
            PACKAGE=".Packages/$2/"
            FOLDER=".Packages/$2"
            PKG="$2"
            if [ -d "$PACKAGE" ]; then
                if [ -f "$PACKAGE/info" ]; then
                    DESCRIPTION=$(grep "Description:" "$PACKAGE"/info | cut -d ":" -f2- | sed 's/^ *//')
                    VERSION=$(grep "Version:" "$PACKAGE"/info | cut -d ":" -f2- | sed 's/^ *//')
                    CREATOR=$(grep "Creator:" "$PACKAGE"/info | cut -d ":" -f2- | sed 's/^ *//')
                    BUNDLE=$(grep "Bundle:" "$PACKAGE"/info | cut -d ":" -f2- | sed 's/^ *//')
                    RELEASE=$(grep "Release:" "$PACKAGE"/info | cut -d ":" -f2- | sed 's/^ *//')
                    echo "= $PKG"
                    echo "$DESCRIPTION"
                    echo ""
                    echo "$CREATOR - $BUNDLE"
                    echo "$VERSION ~ $RELEASE Release"
                else
                    echo -e "\033[1;33mInfo is not available for this package.\033[0m"
                fi
            else
                echo -e "\033[1m\033[33mPackage is not available/found.\033[0m"
            fi
            exit 0
            ;;
        -a|--allpkgs)
            DIR=$(pwd)
            echo -e "\033[1mAvailable Packages:\033[0m"
            for package in "$DIR/.Packages/"*/
            do
                package=$(basename "$package")
                echo -e "\033[1m\033[34m> $package\033[1m\033[34m"
            done
            echo -e "\033[1;37mTo install a package do: $0 -i [Package]\033[1;37m"
            exit 0
            ;;
        -A|-allinstalled)
            echo -e "\033[1mInstalled Packages:\033[0m"
            for dir in /usr/local/in1tpkg/*/; do
                echo -e "\033[1m\033[34m> $(basename "$dir")\033[1m\033[34m"
            done
            exit 0
            ;;
        -s|--search)
            DIR=$(pwd)
            if [ -z "$2" ]; then
                echo -e "\033[1;31mError: Search term not provided\033[0m"
                exit 1
            fi
            echo -e "\033[1mAvailable Packages:\033[0m"
            for PACKAGE_DIR in "$DIR/Packages"/*; do
                package_name=$(basename "$PACKAGE_DIR")
                if echo "$package_name" | grep -qi "$2"; then
                    echo -e "\033[1m\033[34m> $package_name\033[1m\033[0m"
                fi
            done
            echo -e "\033[1;37mTo install a package do: $0 -i [Package]\033[1;37m"
            exit 0
            ;;
        -v)
            PACKAGE=".Packages/$2/"
            FOLDER=".Packages/$2"
            PKG="$2"
            if [ -d "$PACKAGE" ]; then
                if [ -f "$PACKAGE/info" ]; then
                    VERSION=$(grep "Version:" "$PACKAGE"/info | cut -d ":" -f2- | sed 's/^ *//')
                    echo "= $PKG"
                    echo "$VERSION"
                else
                    echo -e "\033[1;33mVersion is not available for this package.\033[0m"
                fi
            else
                echo -e "\033[1m\033[33mPackage is not available/found.\033[0m"
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


