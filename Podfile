# Uncomment the next line to define a global platform for your project
# platform :ios, '15.0'

target 'ColorCards' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ColorCards
#  pod 'Alamofire'
  pod 'Firebase/Firestore'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod "ToastViewSwift"
  pod 'ReachabilitySwift'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
        config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
        config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
        config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
       end
    end
  end
