Pod::Spec.new do |s|
  s.name      = 'WisdomRouterKit'
  s.version   = '0.3.1'
  s.license   = { :type => "MIT", :file => "LICENSE" }
  s.authors   = { 'tangjianfeng' => '497609288@qq.com' }
  s.homepage  = 'https://github.com/tangjianfengVS/WisdomRouterKit'
  s.source    = { :git => 'https://github.com/tangjianfengVS/WisdomRouterKit.git', :tag => s.version }
  s.summary   = 'A powerful router SDK'

  s.description   = "A powerful router SDK.For handling calls between componentized modules, WisdomRouterKit can help you with property parameters between pages and call-back Block transfer assignments without having to refer to each submodule or define a common protocol file to associate each submodule.No maintenance cost is required, no matter how large the project's future functionality or business scale.API call convenience, flexible use, just a few lines of registration code to complete."

  s.platform      = :ios, "9.0"
  s.swift_version = ['5.5', '5.6', '5.7']

  s.ios.deployment_target = '9.0'
  # s.osx.deployment_target = ''
  # s.watchos.deployment_target = ''
  # s.tvos.deployment_target = ''

  s.source_files  = 'Source/*.swift', 'Source/*.{h,m}'
  #s.dependency ""

end
