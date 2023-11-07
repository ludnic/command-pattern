#!/usr/bin/env bash 

if [ $# == 1 ]; then 
  profile=$1
else
  profile="release"
fi

echo "Building in $profile mode"

current_dir="$(cd "$(dirname "$0")"; pwd -P)"

fpm clean --skip
fpm install --prefix "$current_dir" --profile "$profile"