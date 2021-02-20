#!/usr/bin/env bash

ANDROID_HOME="$HOME/Library/Android/sdk"
CMDLINE_TOOLS_REPOSITORY="commandlinetools-mac-6858069_latest.zip"
PLATFORMS_ANDROID_VERSION="platforms;android-30"
BUILD_TOOLS_VERSION="build-tools;29.0.2"
ANDROID_SYSTEM_IMAGES_VERSION="system-images;android-30;google_apis;x86_64"
AVD_NAME="android30"
JAVA_BIN_LOCATION="/usr/bin/java"
HOMEBREW_BIN_LOCATION="/usr/local/bin/brew"

download_and_unzip_cmdlinetools() {
  command curl https://dl.google.com/android/repository/${CMDLINE_TOOLS_REPOSITORY} -o $HOME/android-sdk.zip
  command unzip $HOME/android-sdk.zip -d $HOME/.tmp-android
}

create_directory_android_sdk() {
  command mkdir ~/Library/Android && mkdir ~/Library/Android/sdk && mkdir ~/Library/Android/sdk/cmdline-tools
  command mv $HOME/.tmp-android/cmdline-tools ~/Library/Android/sdk/cmdline-tools/latest
}

setup_android_environment() {
  export $ANDROID_HOME
  local ANDROID_HOME
}

install_sdkmanager_packages() {
  command sdkmanager "platform-tools" ${PLATFORMS_ANDROID_VERSION} ${BUILD_TOOLS_VERSION}
}

install_system_images() {
  command sdkmanager ${ANDROID_SYSTEM_IMAGES_VERSION}
}

create_avdmanager() {
  command avdmanager create avd --name ${AVD_NAME} --package ${ANDROID_SYSTEM_IMAGES_VERSION}
}

suggest_setup_enviroment() {
  printf %s "please fill this config tou your .zshrc, .bashrc, or .profile"
  command cat ./enviroment.txt
}

if [[ ! -n "$HOMEBREW_BIN_LOCATION" ]]; then
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  command brew --version
fi

if [[ -n "$JAVA_BIN_LOCATION" ]]; then
  command java -version
else
  brew search adoptopenjdk/openjdk/adoptopenjdk8
  brew cask install adoptopenjdk/openjdk/adoptopenjdk8
fi

if [[ -n "$ANDROID_HOME" ]]; then
  local ANDROID_HOME
else
  download_and_unzip_cmdlinetools
  create_directory_android_sdk
  setup_android_environment
  install_sdkmanager_packages
  install_system_images
  create_avdmanager
  suggest_setup_enviroment
fi
