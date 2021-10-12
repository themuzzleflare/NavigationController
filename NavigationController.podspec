Pod::Spec.new do |spec|
  spec.name = 'NavigationController'
  spec.version = '2.0.0'
  spec.author = { 'Paul Tavitian' => 'paul@tavitian.cloud' }
  spec.social_media_url = 'https://twitter.com/TheMuzzleFlare'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage = 'https://github.com/themuzzleflare/NavigationController'
  spec.source = { :git => 'https://github.com/themuzzleflare/NavigationController.git', :tag => spec.version.to_s }
  spec.summary = 'UINavigationController for AppKit'
  spec.platform = :osx, '10.10'
  spec.frameworks = 'Foundation', 'AppKit'
  spec.source_files = 'Sources/**/*.swift'
end
