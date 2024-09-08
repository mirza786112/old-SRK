import UIKit
import Flutter
import AVKit

private let CHANNEL = "pip.channel"

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var player: AVPlayer?
    var isMuted: Bool = false

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "enterPiPMode" {
                self?.enterPiPMode(result: result)
            } else if call.method == "toggleMute" {
                self?.toggleMute(result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        GeneratedPluginRegistrant.register(with: self)

        // Block screenshots and screen recording
        let secureView = UIView()
        secureView.frame = UIScreen.main.bounds
        secureView.backgroundColor = UIColor.clear
        secureView.isUserInteractionEnabled = false
        window?.addSubview(secureView)
        window?.bringSubviewToFront(secureView)
//        secureView.isSecureTextEntry = true

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func enterPiPMode(result: @escaping FlutterResult) {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            result(FlutterError(code: "NO_ROOT_VIEW_CONTROLLER", message: "No root view controller found", details: nil))
            return
        }
        let playerLayer = AVPlayerLayer(player: player)
        let player = AVPictureInPictureController(playerLayer: playerLayer)
//        if player.isPictureInPictureSupported {
//            player.startPictureInPicture()
//            result(nil)
//        } else {
//            result(FlutterError(code: "NOT_SUPPORTED", message: "Picture-in-Picture mode is not supported on this device", details: nil))
//        }
    }

    private func toggleMute(result: @escaping FlutterResult) {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            result(FlutterError(code: "NO_ROOT_VIEW_CONTROLLER", message: "No root view controller found", details: nil))
            return
        }
        if let player = self.player {
            isMuted = !isMuted
            player.isMuted = isMuted
            result(isMuted)
        } else {
            result(FlutterError(code: "NO_PLAYER", message: "No AVPlayer instance found", details: nil))
        }
    }
}
