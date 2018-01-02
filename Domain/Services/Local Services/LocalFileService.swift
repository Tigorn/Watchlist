import Foundation

public protocol LocalFileServiceProtocol {
    func defaultCurrencySymbols() -> [CurrencySymbol]
}

public class LocalFileService: LocalFileServiceProtocol {
    var bundle = Bundle.domain

    public init() {}

    public func defaultCurrencySymbols() -> [CurrencySymbol] {
        if let path = bundle.path(forResource: "SymbolDefaults", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path),
            let symbols = dictionary["symbols"] as? [String] {
            return symbols.enumerated().map { CurrencySymbol(symbol: $0.element, index: $0.offset) }
        }

        return []
    }
}
