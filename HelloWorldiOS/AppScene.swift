import AppFeature
import ComposableArchitecture
import SwiftUI

@main
struct AppScene: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

  var body: some Scene {
    WindowGroup {
      AppView(store: appDelegate.store)
    }
  }
}
