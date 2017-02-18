Pod::Spec.new do |s|
s.name = 'ELAlertController'
s.version = '1.0'
s.license = { :type => "MIT", :file => "LICENSE" }
s.summary = '高仿UIAlertController可支持iPad的actionSheet,支持弹出自定义视图的alert '
s.homepage = 'https://github.com/zhanglinfeng/ELAlertController'
s.authors = { '张林峰' => '1051034428@qq.com' }
s.source = { :git => 'https://github.com/zhanglinfeng/ELAlertController.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'ELAlertControllerDemo/ELAlertController/*.{h,m}'
s.dependency "Masonry"
end
