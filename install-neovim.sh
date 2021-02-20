#!/usr/bin/env bash

help_intro() {
  echo "Please type (source ./install-neovim.sh install)"
}

install() {
  echo "install.."
}

case "$1" in
  install)
    install
    ;;
  *)
    help_intro
    ;;
esac
