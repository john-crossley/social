# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Social' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Social
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/Auth'
  pod 'CodableFirebase'
  pod 'GyozaKit'
  pod 'SnapKit'
  pod 'DateToolsSwift'

  target 'SocialTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SocialUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  legacy_pods = ['SnapKit']

  post_install do | installer |
    installer.pods_project.targets.each do |target|
      if legacy_pods.include?(target.name)
        target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = '4.1'
        end
      end
    end
  end

end
