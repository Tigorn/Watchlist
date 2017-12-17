import Foundation

public protocol LocalFileServiceProtocol {
    func defaultCurrencySymbols() -> [String]
}

public class LocalFileService: LocalFileServiceProtocol {
    var bundle = Bundle.domain

    public init() {}

    public func defaultCurrencySymbols() -> [String] {
        if let path = bundle.path(forResource: "SymbolDefaults", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path),
            let symbols = dictionary["symbols"] as? [String] {
            return symbols
        }

        return []
    }
}
