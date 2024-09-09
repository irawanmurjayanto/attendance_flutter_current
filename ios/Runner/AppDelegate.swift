import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your Google Maps API key
  //  GMSServices.provideAPIKey("AIzaSyDM9f2ZnWAsDL6KKX92qMwaw4Qr4njqjv4")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
