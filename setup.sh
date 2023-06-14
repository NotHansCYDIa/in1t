echo "Welcome to in1t setup!"
# didnt do anything on setup.sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 <in1t_installation_file>"
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "Error: file '$1' not found"
  exit 1
fi

DIR=$(pwd)

if [ -f /usr/local/bin/in1t ]; then
  echo "Removing existing in1t installation..."
  sudo rm /usr/local/bin/in1t
fi

mv "$1" "in1t"
chmod +x "in1t"
sudo ln -s "$DIR/in1t" /usr/local/bin/in1t

if [ $? -eq 0 ]; then
  echo "in1t setup is complete! You can now run: in1t -h"
else
  echo "Error: something went wrong during installation"
fi

