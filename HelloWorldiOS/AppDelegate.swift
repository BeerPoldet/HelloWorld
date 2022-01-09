import AppFeature
import ComposableArchitecture
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
  let store = Store(
    initialState: AppState.loading,
    reducer: appReducer,
    environment: AppEnvironment(
      mainQueue: .main,
      now: Date.init
    )
  )
  lazy var viewStore: ViewStore<(), AppAction> = ViewStore(
    self.store.scope(state: { _ in () }),
    removeDuplicates: ==
  )

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    true
  }

  func applicationWillTerminate(_ application: UIApplication) {}
}
