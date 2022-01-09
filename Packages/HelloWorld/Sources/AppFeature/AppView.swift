import ComposableArchitecture
import Resource
import SwiftUI

public struct AppView: View {
  let store: Store<AppState, AppAction>

  public init(store: Store<AppState, AppAction>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store) { _ in
      Text(L10N.greet)
    }
  }
}

#if DEBUG
  struct AppView_Previews: PreviewProvider {
    static var previews: some View {
      AppView(
        store: Store(
          initialState: AppState.loading,
          reducer: appReducer,
          environment: AppEnvironment(
            mainQueue: .main,
            now: Date.init
          )
        )
      )
      .preferredColorScheme(.light)

      AppView(
        store: Store(
          initialState: AppState.loading,
          reducer: appReducer,
          environment: AppEnvironment(
            mainQueue: .main,
            now: Date.init
          )
        )
      )
      .preferredColorScheme(.dark)
    }
  }
#endif
