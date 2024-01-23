#!/bin/sh

# The default execution directory of this script is the ci_scripts directory.
cd $CI_PRIMARY_REPOSITORY_PATH # change working directory to the root of your cloned repo.
# Install Flutter using git.
git clone https://github.com/flutter/flutter.git --depth 1 -b stable $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

flutter doctor

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --macos

# Install Flutter dependencies.
flutter pub get

# Install CocoaPods using Homebrew.
HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
brew install cocoapods

cd macos && pod install

flutter build macos --config-only

# Install CocoaPods dependencies.
# cd macos && pod install # run `pod install` in the `ios` directory.

exit 0