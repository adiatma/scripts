#!/usr/bin/env bash

HOMEBREW_BIN_LOCATION="/usr/local/bin/brew"
NVIM_BIN_LOCATION="/usr/local/bin/nvim"

help_intro() {
  echo "Usage: (install)"
}

install() {
  if [[ ! -n "$NVIM_BIN_LOCATION" ]]; then
    if [[ -n "$HOMEBREW_BIN_LOCATION" ]]; then
      command brew install neovim   
    fi
  else
    command nvim --version
  fi

}

case "$1" in
  install)
    install
    ;;
  *)
    help_intro
    ;;
esac
