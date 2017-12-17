import Foundation

public protocol LocalDefaultsServiceProtocol {
    var didSetDefaultCurrencies: Bool { get set }
}

fileprivate enum UserDefaultsKeys: String {
    case didSetDefaultCurrencies
}

public class LocalDefaultsService: LocalDefaultsServiceProtocol {
    var userDefaults = UserDefaults.standard

    public init() {}

    public var didSetDefaultCurrencies: Bool {
        get {
            return userDefaults.bool(forKey: UserDefaultsKeys.didSetDefaultCurrencies.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultsKeys.didSetDefaultCurrencies.rawValue)
            userDefaults.synchronize()
        }
    }
}
