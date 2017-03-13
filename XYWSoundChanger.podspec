

Pod::Spec.new do |s|

  s.name         = "XYWSoundChanger"
  s.version      = "0.1.0"
  s.summary      = "XYWSoundChanger 变声器"

  s.homepage     = "https://github.com/xueyongwei/XYWSoundChanger.git"
 
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "xueyognwei" => "xueyongwei@foxmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/xueyongwei/XYWSoundChanger.git", :tag => s.version}

  s.source_files  = "XYWSoundChanger/ZYSoundChanger/*.{h,m}"
  
  #s.dependency 'AFNetworking'

  #s.dependency 'YYCache'

  s.requires_arc = true

end
