Pod::Spec.new do |s|
s.name = 'ZinkPhotoVideo'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = '从相册或摄像头获取用户相片及视频'
s.homepage = 'https://github.com/zinkLin'
s.authors = { 'Zink' => '418175138@qq.com' }
s.source = { :git => "https://github.com/zinkLin/ZinkPhotoVideo", :tag => "1.0.0"}
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = "ZinkPhotoVideo/*"
s.dependency 'ZinkAlertActionSheet'
end