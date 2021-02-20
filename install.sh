#!/usr/bin/env bash

print_help() {
  echo "source ./install.sh (-a|-r)"
}

case "$1" in
  -a | --android)
    source ./setup-android-environment-for-macos.sh
    ;;
  -r | --rust)
    source ./rust-install.sh
    ;;
  *)
    print_help
    ;;
esac
