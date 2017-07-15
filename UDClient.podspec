Pod::Spec.new do |s|

  s.name = "UDClient"
  s.version = "0.1"
  s.summary = "Super easy to use Udacity Auth and Classroom APIs client for iOS"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.homepage = "https://github.com/omaralbeik/UDClient"
  s.author = { "Omar Albeik" => "omaralbeik@gmail.com" }
  s.social_media_url = "https://twitter.com/omaralbeik"
  s.platform = :ios, "9.0"
  s.requires_arc = "true"
  s.source = { git: "https://github.com/omaralbeik/UDClient.git", tag: "#{s.version}" }
  s.source_files = "Sources/**/*.swift"
  s.pod_target_xcconfig = {
    "SWIFT_VERSION" => "3.0",
  }
  s.dependency "AlamofireObjectMapper", "~> 4.1"
  s.dependency "GraphQLicious", "~> 0.8"
  s.dependency "JWTDecode", "~> 2.0"
  s.dependency "SwiftyJSON", "~> 3.1"
  s.dependency "SwifterSwift", "~> 1.6"
end
