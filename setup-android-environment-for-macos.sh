#!/usr/bin/env bash

ANDROID_HOME="$HOME/Library/Android/sdk"
CMDLINE_TOOLS_REPOSITORY="commandlinetools-mac-6858069_latest.zip"
PLATFORMS_ANDROID_VERSION="platforms;android-30"
BUILD_TOOLS_VERSION="build-tools;29.0.2"
ANDROID_SYSTEM_IMAGES_VERSION="system-images;android-30;google_apis;x86_64"
AVD_NAME="android30"

download_and_unzip_cmdlinetools() {
  curl https://dl.google.com/android/repository/${CMDLINE_TOOLS_REPOSITORY} -o $HOME/android-sdk.zip
  unzip $HOME/android-sdk.zip -d $HOME/.tmp-android
}

create_directory_android_sdk() {
  mkdir ~/Library/Android && mkdir ~/Library/Android/sdk && mkdir ~/Library/Android/sdk/cmdline-tools
  mv $HOME/.tmp-android/cmdline-tools ~/Library/Android/sdk/cmdline-tools/latest
}

setup_android_environment() {
  export $ANDROID_HOME
  local ANDROID_HOME
}

install_sdkmanager_packages() {
  sdkmanager "platform-tools" ${PLATFORMS_ANDROID_VERSION} ${BUILD_TOOLS_VERSION}
}

install_system_images() {
  sdkmanager ${ANDROID_SYSTEM_IMAGES_VERSION}
}

create_avdmanager() {
  avdmanager create avd --name ${AVD_NAME} --package ${ANDROID_SYSTEM_IMAGES_VERSION}
}

if [[ -e "/usr/local/bin/brew" ]]; then
  echo "✅ brew exists"
else
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
fi

if [[ -e "/usr/bin/java" ]]; then
  java -version
else
  brew cask install adoptopenjdk/openjdk/adoptopenjdk8
fi

if [[ -e "$ANDROID_HOME" ]]; then
  local ANDROID_HOME
else
  download_and_unzip_cmdlinetools
  create_directory_android_sdk
  setup_android_environment
  install_sdkmanager_packages
  install_system_images
  create_avdmanager
fi
