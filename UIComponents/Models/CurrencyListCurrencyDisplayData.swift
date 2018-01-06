import FoundationComponents

public protocol CurrencyProtocol {
    var symbol: String { get }
    var lastPrice: Double? { get }
}

public struct CurrencyListCurrencyDisplayData {
    public let sections: [CurrencyListCurrencyDisplaySection]

    public init() {
        sections = []
    }

    public init(currencies: [CurrencyProtocol]) {
        let items = currencies.map { currency in
            return CurrencyListCurrencyDisplayItem(name: currency.symbol, lastPrice: currency.lastPrice)
        }

        let section = CurrencyListCurrencyDisplaySection(items: items)

        sections = [section]
    }

    public var sectionCount: Int {
        return sections.count
    }

    public func itemCount(inSection section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }

    public func itemAt(indexPath: IndexPath) -> CurrencyListCurrencyDisplayItem? {
        return sections[safe: indexPath.section]?.items[indexPath.row]
    }
}

public struct CurrencyListCurrencyDisplaySection {
    public var items = [CurrencyListCurrencyDisplayItem]()
}

public struct CurrencyListCurrencyDisplayItem {
    public let name: String?
    public let lastPrice: Double?
}
