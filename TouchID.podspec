
Pod::Spec.new do |s|
  s.name         = "TouchID"
  s.version      = "1.1.0"
  s.summary      = "An iOS TouchID library."
  s.description  = "TouchID is an iOS TouchID library."
  s.homepage     = "https://github.com/Meniny/TouchID"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Elias Abel" => "Meniny@qq.com" }
  s.social_media_url   = "https://meniny.cn"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Meniny/TouchID.git", :tag => "#{s.version}" }
  s.source_files  = "TouchID/*"
  s.public_header_files = "TouchID/*.h"
  s.frameworks = "Foundation", "LocalAuthentication"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
end
