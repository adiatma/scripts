#!/usr/bin/env bash

print_help() {
  echo "Usage: (--android|--rust|--neovim)"
}

case "$1" in
  -a | --android)
    source ./setup-android-environment-for-macos.sh --install
    ;;
  -r | --rust)
    source ./rust-install.sh
    ;;
  -n | --neovim)
    source ./install-neovim.sh install
    ;;
  *)
    print_help
    ;;
esac
