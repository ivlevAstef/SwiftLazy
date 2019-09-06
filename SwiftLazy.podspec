Pod::Spec.new do |s|

  s.name         = 'SwiftLazy'
  s.version      = '1.1.5'
  s.summary      = 'SwiftLazy - classes (Lazy, Provide) is intended for late initialization on iOS/macOS/tvOS (Swift)'

  s.description  = <<-DESC
            Swift allows for lazy variables out-of-the-box, however they're fairly restricted.
  					SwiftLazy - classes (Lazy, Provide) is intended for late initialization on iOS/macOS/tvOS (Swift)
            DESC

  s.homepage     = 'https://github.com/ivlevAstef/SwiftLazy'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { 'Alexander.Ivlev' => 'ivlev.stef@gmail.com' }
  s.source       = { :git => 'https://github.com/ivlevAstef/SwiftLazy.git', :tag => "v#{s.version}" }

  s.requires_arc = true

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'

  s.source_files = 'Sources/SwiftLazy.h', 'Sources/**/*.swift'
  
end
