#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'salesforce'
  s.version          = '6.1.0'
  s.summary          = 'Flutter plugin for the Salesforce Mobile SDK.'
  s.description      = 'Flutter plugin for the Salesforce Mobile SDK.'
  s.homepage         = "https://github.com/forcedotcom/SalesforceMobileSDK-FlutterPlugin"
  s.license          = { :type => "Salesforce.com Mobile SDK License", :file => "../LICENSE.md" }
  s.author           = { "Wolfgang Mathurin" => "wmathurin@salesforce.com" }
  s.source           = { :path => '../' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'SalesforceSDKCommon'
  s.dependency 'SalesforceSDKCore'
  s.dependency 'SalesforceAnalytics'
  s.dependency 'SmartStore'
  s.dependency 'MobileSync'

  s.ios.deployment_target = '14.0'
end

