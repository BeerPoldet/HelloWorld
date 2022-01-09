import Foundation

private class CurrentBundleFinder {}

private let package = "HelloWorld"

public extension Foundation.Bundle {
  static func resource(_ name: String) -> Bundle {
    /* The name of your local package, prepended by "LocalPackages_" for iOS and "PackageName_" for macOS. You may have same PackageName and TargetName*/
    let bundleNameIOS = "\(package)_\(name)"
    let bundleNameMacOs = "\(package)_\(name)"
    let candidates = [
      /* Bundle should be present here when the package is linked into an App. */
      Bundle.main.resourceURL,
      /* Bundle should be present here when the package is linked into a framework. */
      Bundle(for: CurrentBundleFinder.self).resourceURL,
      /* For command-line tools. */
      Bundle.main.bundleURL,
      /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
      Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent()
        .deletingLastPathComponent().deletingLastPathComponent(),
      Bundle(for: CurrentBundleFinder.self).resourceURL?.deletingLastPathComponent()
        .deletingLastPathComponent()
    ]

    for candidate in candidates {
      let bundlePathiOS = candidate?.appendingPathComponent(bundleNameIOS + ".bundle")
      let bundlePathMacOS = candidate?.appendingPathComponent(bundleNameMacOs + ".bundle")
      if let bundle = bundlePathiOS.flatMap(Bundle.init(url:)) {
        return bundle
      } else if let bundle = bundlePathMacOS.flatMap(Bundle.init(url:)) {
        return bundle
      }
    }
    fatalError("unable to find bundle")
  }
}