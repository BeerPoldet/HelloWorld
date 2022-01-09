import ComposableArchitecture

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>
  .init { _, _, _ in
    .none
  }
