Pod::Spec.new do |s|
  s.name         = "WisdomRouterKit"
  s.version      = "0.0.6"
  s.summary      = "A powerful router SDK"
  s.description  = "A powerful router SDK.For handling calls between componentized modules, WisdomRouterKit can help you with property parameters between pages and call-back Block transfer assignments without having to refer to each submodule or define a common protocol file to associate each submodule.No maintenance cost is required, no matter how large the project's future functionality or business scale.API call convenience, flexible use, just a few lines of registration code to complete."

  s.homepage     = "https://github.com/tangjianfengVS/WisdomRouterKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "tangjianfeng" => "497609288@qq.com" }
  s.platform     = :ios, "8.0"
  s.swift_version= '4.2'
  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/tangjianfengVS/WisdomRouterKit.git", :tag => s.version }
  s.source_files  = "WisdomRouterKit/WisdomRouterKit/WisdomRouterKit/*.swift"

  #s.resources = "WisdomScanKitDemo/WisdomScanKitDemo/WisdomScanKit/WisdomScanKit.bundle"
  #s.dependency ""
end
