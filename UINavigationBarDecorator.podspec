#
# Be sure to run `pod lib lint UINavigationBarDecorator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UINavigationBarDecorator'
  s.version          = '0.1.0'
  s.summary          = 'Compatible UINavigationBarAppearance'
  s.description      = 'Compatible UINavigationBarAppearance for all ios versions'
  s.homepage         = 'https://github.com/pisces/UINavigationBarDecorator'
  s.license          = { :type => 'BSD', :file => 'LICENSE' }
  s.author           = { 'Steve Kim' => 'hh963103@gmail.com' }
  s.source           = { :git => 'https://github.com/pisces/UINavigationBarDecorator.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'UINavigationBarDecorator/Classes/**/*'
end
