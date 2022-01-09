import ComposableArchitecture

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>
  .init { state, action, environment in
    return .none
  }
