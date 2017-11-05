# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'RemineMe' do
    use_frameworks!
    pod 'SideMenu'
    pod 'TesseractOCRiOS', '4.0.0'
  # Pods for RemineMe
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end
end

