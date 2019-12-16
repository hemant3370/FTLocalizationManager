#
# Be sure to run `pod lib lint FTLocalizationManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FTLocalizationManager'
  s.version          = '1.2.8'
  s.summary          = 'Localization Manager with RTL support'


  s.homepage         = 'https://github.com/farabis4m/FTLocalizationManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Abdulla' => 'abdulla@farabi.ae' }
  s.source           = { :git => 'https://github.com/farabis4m/FTLocalizationManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'FTLocalizationManager/Classes/**/*'
end
