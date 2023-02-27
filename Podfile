# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

workspace 'MovieDB.xcworkspace'

target 'MovieDB' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  use_modular_headers!

  # Pods for MovieDB
  pod 'Moya'
  pod 'Kingfisher'
  pod 'SkeletonView', '1.30.3'
  pod 'SnapKit'
  pod 'youtube-ios-player-helper'

  target 'MovieDBTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
  end

  target 'MovieDBUITests' do
    # Pods for testing
  end

end
