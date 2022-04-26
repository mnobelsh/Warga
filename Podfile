platform :ios, '13.0'

def firebase_pods
    pod 'Firebase/Auth'
    pod 'FirebaseFirestore'
    pod 'FirebaseFirestoreSwift'
end

def ui_pods
    pod 'FloatingPanel'
    pod 'SVProgressHUD'
    pod "LetterAvatarKit", "1.2.3"
    pod 'ChameleonFramework/Swift', :git => 'https://github.com/wowansm/Chameleon.git', :branch => 'swift5'
    pod "PageControls/SnakePageControl"
end

target 'Warga' do
  use_frameworks!
  firebase_pods
  ui_pods
  pod 'ReachabilitySwift'
end


