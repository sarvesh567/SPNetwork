Pod::Spec.new do |s|
  s.name             = 'SPNetwork'
  s.version          = '1.1.3'
  s.summary          = 'Handle networking.'
  s.description      = <<-DESC
Handle networking.
                       DESC

  s.homepage         = 'https://github.com/sarvesh567/SPNetwork'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sarvesh567' => 'sp395862@gmail.com' }
  s.source           = { :git => 'https://github.com/sarvesh567/SPNetwork.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'SPNetwork/Classes/**/*'
  s.dependency 'Alamofire', '~> 5.4.4'
end
