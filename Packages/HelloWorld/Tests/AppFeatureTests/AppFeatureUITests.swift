@testable import AppFeature

import ComposableArchitecture
import SnapshotTesting
import XCTest

class AppFeatureUITests: XCTestCase {
  override class func setUp() {
//    isRecording = true
  }

  func testHelloWorld() {
    let appView = AppView(
      store: Store(
        initialState: AppState.loading,
        reducer: .empty,
        environment: ()
      )
    )

    assertSnapshot(matching: appView, as: .image(layout: .device(config: .iPhoneXsMax)))
  }
}
