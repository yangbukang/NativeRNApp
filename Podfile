platform :ios, '9.0'
target 'NativeRNApp' do

  # 'node_modules'目录一般位于根目录中
  # 但是如果你的结构不同，那你就要根据实际路径修改下面的`:path`
  pod 'React', :path => './ReactComponent/node_modules/react-native', :subspecs => [
    'Core',
    'RCTText',
    'RCTNetwork',
    'RCTWebSocket', # 这个模块是用于调试功能的
    'ART',
    'RCTActionSheet',
    'RCTGeolocation',
    'RCTImage',
    'RCTPushNotification',
    'RCTSettings',
    'RCTVibration',
    'RCTLinkingIOS',
    'CxxBridge',
    'RCTAnimation',
  ]
  # 如果你的RN版本 >= 0.42.0，请加入下面这行
  pod 'yoga', :path => './ReactComponent/node_modules/react-native/ReactCommon/yoga'
  pod 'Folly', :podspec => './ReactComponent/node_modules/react-native/third-party-podspecs/Folly.podspec'
  pod 'glog', :podspec => './ReactComponent/node_modules/react-native/third-party-podspecs/glog.podspec'
  
  pod 'AFNetworking', '~> 3.0'
  pod 'Base64', '~> 1.0.1'

end
