// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Bundle
import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
public enum L10N {
  /// Hello
  public static let greet = L10N.tr("L10N", "greet")
}

// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

public var locale = Locale.current

extension L10N {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: locale, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
      return Bundle.resource("Resource")
    #else
      return Bundle(for: BundleToken.self)
    #endif
  }()
}

// swiftlint:enable convenience_type
