#
# Be sure to run `pod lib lint FTLocalizationManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FTLocalizationManager'
  s.version          = '0.1.0'
  s.summary          = 'A short description of FTLocalizationManager.'


  s.homepage         = 'https://github.com/farabis4m/FTLocalizationManager.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Abdulla' => 'abdulla@farabi.ae' }
  s.source           = { :git => 'https://github.com/farabis4m/FTLocalizationManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'FTLocalizationManager/Classes/**/*'
end
