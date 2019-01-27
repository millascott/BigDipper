# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ProjectDemoSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  pod 'SwiftyJSON'
  #Whisper似乎已不再更新 Swift4.2版本： pod 'Whisper', :git => 'git@github.com:freeubi/Whisper.git', :branch => 'swift-4.2-support'
  #pod 'Whisper'
  pod 'SnapKit'
  pod 'ReactiveCocoa'
  pod 'IQKeyboardManagerSwift'
  pod 'MJRefresh'
  # 监听网络状态
  pod 'ReachabilitySwift'
  
  # SD
  #pod 'SDWebImage'
  pod 'SDCycleScrollView'
  # 弹框
  pod 'SVProgressHUD'

  # 主模块(必须)
  pod 'mob_sharesdk'
  # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
  pod 'mob_sharesdk/ShareSDKUI'
  # 平台SDK模块(对照一下平台，需要的加上。如果只需要QQ、微信、新浪微博，只需要以下3行)
  pod 'mob_sharesdk/ShareSDKPlatforms/QQ'
  pod 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo'
  pod 'mob_sharesdk/ShareSDKPlatforms/WeChat'   #（微信sdk不带支付的命令）

  # Pods for ProjectDemoSwift

  target 'ProjectDemoSwiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ProjectDemoSwiftUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
