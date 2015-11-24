Pod::Spec.new do |s|

  s.name         = "ESThread"
  s.version      = "0.1.0"
  s.summary      = "A simply threading support functions for iOS/OSX in Swift."

  s.description  = <<-DESC
                   It is a swift module that simply support threading functions. This module written in Swift 2.0.
                   DESC

  s.homepage     = "https://github.com/EZ-NET/ESThread"

  s.license      = { :type => "MIT" }

  s.author             = { "Tomohiro Kumagai" => "http://ez-net.jp/profile/" }
  s.social_media_url   = "http://twitter.com/es_kumagai"

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.source       = { :git => "https://github.com/EZ-NET/ESThread.git", :tag => s.version }
  s.source_files  = "ESThread/**/*.swift"

end

