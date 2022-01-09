import ComposableArchitecture

public struct AppEnvironment {
  public init(
    mainQueue: AnySchedulerOf<DispatchQueue>,
    now: @escaping () -> Date
  ) {
    self.mainQueue = mainQueue
    self.now = now
  }

  public var mainQueue: AnySchedulerOf<DispatchQueue>
  public var now: () -> Date
}
