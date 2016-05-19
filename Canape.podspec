#
# Be sure to run `pod lib lint Canape.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Canape"
  s.version          = "0.1.0"
  s.summary          = "Canape framework"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "Canape framework."

  s.homepage         = "https://github.com/bliex/canape"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "bliex" => "canape@bliex.com" }
  s.source           = { :git => "https://github.com/bliex/canape.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.public_header_files = 'Canape/Classes/Canape.h'

  s.subspec 'Category' do |category|
    category.source_files = "Canape/Classes/Category/*.{h,m}"
  end

  s.subspec 'Common' do |common|
    common.source_files = "Canape/Classes/CanapeConstants.h"
    common.dependency "Canape/Category"
  end

  s.subspec 'Utils' do |utils|
    utils.source_files = "Canape/Classes/Utils/*.{h,m}"
    utils.dependency "Canape/Common"
  end

  s.subspec 'ActionSheet' do |actionSheet|
    actionSheet.source_files = "Canape/Classes/ActionSheet/*.{h,m}"
    actionSheet.dependency 'Canape/Utils'
  end

  s.subspec 'Alert' do |alert|
    alert.source_files = "Canape/Classes/Alert/*.{h,m}"
    alert.dependency 'Canape/Utils'
  end

  s.subspec 'BaseController' do |baseController|
    baseController.source_files = "Canape/Classes/BaseController/*.{h,m}"
  end

  s.subspec 'Combo' do |combo|
    combo.source_files = "Canape/Classes/Combo/*.{h,m}"
  end

  s.subspec 'Encryption' do |encryption|
    encryption.source_files = "Canape/Classes/Encryption/*.{h,m}"
  end

  s.subspec 'Hybrid' do |hybrid|
    hybrid.source_files = "Canape/Classes/Hybrid/*.{h,m}"
    hybrid.dependency "Canape/BaseController"
  end

  s.subspec 'Loader' do |loader|
    loader.source_files = "Canape/Classes/Loader/*.{h,m}"
  end

  s.subspec 'PlistManager' do |plistManager|
    plistManager.source_files = "Canape/Classes/PlistManager/*.{h,m}"
    plistManager.dependency "Canape/Encryption"
  end

  s.subspec 'SelectableButton' do |selectableButton|
    selectableButton.source_files = "Canape/Classes/SelectableButton/*.{h,m}"
  end

  s.subspec 'StackView' do |stackView|
    stackView.source_files = "Canape/Classes/StackView/*.{h,m}"
  end

  s.subspec 'Toast' do |toast|
    toast.source_files = "Canape/Classes/Toast/*.{h,m}"
    toast.dependency "Canape/Common"
  end

  s.subspec 'Token' do |token|
    token.source_files = "Canape/Classes/Token/*.{h,m}"
  end

  s.subspec 'Validation' do |validation|
    validation.source_files = "Canape/Classes/Validation/*.{h,m}"
    validation.dependency "Canape/Combo"
  end

  s.subspec 'ViewPager' do |viewPager|
    viewPager.source_files = "Canape/Classes/ViewPager/*.{h,m}"
  end

  s.resource_bundles = {
    'Canape' => ['Canape/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'CommonCrypto', '~> 1.1'
end
