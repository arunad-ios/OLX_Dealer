Pod::Spec.new do |spec|
  spec.name          = 'OLX_Dealer'
  spec.version       = '1.3.2'
  spec.summary       = 'OLX_Dealer'
  spec.description   = 'OLX_Dealer Module'
  spec.homepage      = 'https://cocoapods.org/pods/OLX_Dealer'
  spec.author        = { 'arunad-ios' => 'arunakumari.d@cartrade.com' }
spec.license = { :type => 'MIT', :text => <<-LICENSE
    Copyright (c) 2025 Your Company
    Permission is hereby granted...
    LICENSE
}
  spec.static_framework = true
  spec.source        = { :git => 'https://github.com/arunad-ios/OLX_Dealer.git', :tag => spec.version.to_s }
  spec.swift_version = '5.0'
  spec.ios.deployment_target = '13.0'
  spec.source_files  = "OLX_BuyLeads/**/*.{h,m,swift}","OLX_BuyLeads/*.{h,m,swift}"
  spec.resource_bundles = {
  'OLX_BuyLeads' => ['OLX_BuyLeads/Resources/Images.xcassets','OLX_BuyLeads/Resources/Fonts/*.ttf']
  }


   # spec.resources = "OLX_BuyLeads/Resources/Images.xcassets"
  #  spec.resources = 'OLX_BuyLeads/*.xcdatamodeld'
  # spec.ios.vendored_frameworks = [
  #  "Frameworks/auth_library.xcframework",
   # "Frameworks/analytics_library.xcframework"
   #  spec.dependency 'HostApp'
  #]
end
