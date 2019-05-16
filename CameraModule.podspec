#
#  Be sure to run `pod spec lint CameraModule.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  
  spec.name         = 'CameraModule'
  spec.version      = '0.0.1'
  spec.summary      = 'A short description of CameraModule.'
  spec.description  = <<-DESC
  Camera Module
  DESC
  
  spec.homepage     = 'https://ibuldapp.com'
  spec.license      = 'Private'
  spec.author             = { 'Anton Boyarkin' => 'anton@solovat.net' }
  spec.platform     = :ios, '10.0'
  spec.source       = { :git => '', :tag => '#{spec.version}' }
  spec.source_files = 'Source/*.swift', 'Source/**/*.swift'
  spec.frameworks = 'UIKit', 'Foundation'
  spec.dependency 'AppBuilderCore'
  spec.dependency 'AppBuilderCoreUI'
  spec.dependency 'NextLevel'
  
end
