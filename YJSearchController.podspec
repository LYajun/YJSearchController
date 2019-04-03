Pod::Spec.new do |s|

  s.name         = "YJSearchController"
  s.version      = "1.0.0"
  s.summary      = "搜索"


  s.homepage     = "https://github.com/LYajun/YJSearchController"
 

  s.license      = "MIT"
 
  s.author             = { "刘亚军" => "liuyajun1999@icloud.com" }
 

  s.platform     = :ios, "8.0"

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/LYajun/YJSearchController.git", :tag => s.version }


  s.source_files  = "YJSearchController/Base/*.{h,m}","YJSearchController/Main/*.{h,m}","YJSearchController/Match/*.{h,m}","YJSearchController/Public/*.{h,m}","YJSearchController/Record/*.{h,m}"

  s.subspec "PinYin" do |ss|
    ss.source_files =  "YJSearchController/PinYin/*.{h,m}"
  end

  s.resources = "YJSearchController/YJSearchController.bundle"

  s.requires_arc = true

  s.dependency 'Masonry'
  s.dependency 'LGAlertHUD'
  s.dependency 'YJExtensions'

end
