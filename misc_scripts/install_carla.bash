#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

sudo apt-get install build-essential clang-3.9 git cmake ninja-build python3-requests python-dev tzdata sed curl wget unzip autoconf libtool 

# compatibility issue avoidance
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-3.9/bin/clang++ 100
sudo update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-3.9/bin/clang 100

mkdir -p ~/git
cd ~/git
git clone https://github.com/carla-simulator/carla
cd carla
./Setup.sh
UE4_ROOT=~/git/UnrealEngine_4.18 ./Rebuild.sh

echo "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-"
echo "Now please refer to the remaining instructions to test CARLA."
echo "Find this here: https://carla.readthedocs.io/en/stable/how_to_build_on_linux/"
echo "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-"
