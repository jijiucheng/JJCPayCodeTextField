
Pod::Spec.new do |s|

    s.name          = 'JJCPayCodeTextField'
    s.version       = '0.2.0'
    s.license       = 'MIT'
    s.summary       = 'A Library for iOS to use border of pay code.'
    s.homepage      = 'https://github.com/jijiucheng/JJCPayCodeTextField'
    s.authors       = { '苜蓿鬼仙' => '302926124@qq.com' }
    s.source        = { :git => 'https://github.com/jijiucheng/JJCPayCodeTextField.git', :tag => s.version }
    s.source_files  = 'JJCPayCodeTextFieldDemo/JJCPayCodeTextField/*.{h,m}'
    s.platform      = :ios
    s.framework     = 'UIKit'
    s.requires_arc  = true
    s.ios.deployment_target = '9.0'

end
