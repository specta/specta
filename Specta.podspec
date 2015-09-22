Pod::Spec.new do |s|
  s.name     = 'Specta'
  s.version  = '1.0.4'
  s.license  = 'MIT'
  s.summary  = 'A light-weight TDD / BDD framework.'
  s.homepage = 'http://github.com/specta/specta'
  s.author   = { 'Peter Jihoon Kim' => 'raingrove@gmail.com' }
  s.source   = { :git => 'https://github.com/specta/specta.git', :tag => "v#{s.version.to_s}" }

  s.description = 'Specta is a light-weight testing framework that adds RSpec-like DSL to XCTest.'
  s.source_files = 'Specta/Specta/**/*.{h,m}'

  s.frameworks = 'Foundation', 'XCTest'
  s.requires_arc    = true
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'
end
