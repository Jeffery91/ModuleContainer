
Pod::Spec.new do |s|

  s.name             = 'ModuleContainer'
  s.version          = '0.1'
  s.summary          = 'A short description of ModuleContainer.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://git.haomaiyi.com/Apple/Framework/Foundation/MBaseModule'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhangjianfei' => 'zhangjianfei@haomaiyi.com' }
  s.source           = { :git => 'git@git.haomaiyi.com:Apple/Framework/Foundation/MBaseModule.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Class/**'

  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'SnapKit'

end
