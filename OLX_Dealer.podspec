Pod::Spec.new do |spec|
  spec.name          = 'OLX_Dealer'
  spec.version       = '1.0.0'
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
  spec.source        = { :git => 'https://github.com/arunad-ios/inventory_cocoa.git', :tag => spec.version.to_s }
  spec.swift_version = '5.0'
  spec.ios.deployment_target = '13.0'
 spec.source_files  = "inventory_cocoa/**/*.{h,m,swift}","inventory_cocoa/*.{h,m,swift}"
#  spec.resources = 'inventory_cocoa/*.xcdatamodeld'
 # spec.ios.vendored_frameworks = [
  #  "Frameworks/auth_library.xcframework",
   # "Frameworks/analytics_library.xcframework"
  #]
end
