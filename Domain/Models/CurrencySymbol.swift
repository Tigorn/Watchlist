import Foundation

public struct CurrencySymbol {
    public let symbol: String
    let index: Int

    public init(symbol: String, index: Int) {
        self.symbol = symbol
        self.index = index
    }
}

extension CurrencySymbol: Equatable {
    public static func == (lhs: CurrencySymbol, rhs: CurrencySymbol) -> Bool {
        return lhs.symbol == rhs.symbol &&
            lhs.index == rhs.index
    }
}

extension CurrencySymbol: Comparable {
    public static func < (lhs: CurrencySymbol, rhs: CurrencySymbol) -> Bool {
        return lhs.index < rhs.index
    }
}
