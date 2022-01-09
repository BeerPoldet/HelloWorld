import ComposableArchitecture

public extension Reducer {
  func lifecycle(
    onAppear: @escaping (Environment) -> Effect<Action, Never>,
    onDisappear: @escaping (Environment) -> Effect<Never, Never>
  ) -> Reducer<State?, LifecycleAction<Action>, Environment> {
    .init { state, lifecycleAction, environment in
      switch lifecycleAction {
      case .onAppear:
        return onAppear(environment).map(LifecycleAction.action)

      case .onDisappear:
        return onDisappear(environment).fireAndForget()

      case let .action(action):
        guard state != nil else { return .none }
        return self.run(&state!, action, environment)
          .map(LifecycleAction.action)
      }
    }
  }
}

public enum LifecycleAction<Action> {
  case onAppear
  case onDisappear
  case action(Action)
}

extension LifecycleAction: Equatable where Action: Equatable {}
