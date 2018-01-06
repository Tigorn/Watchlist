import Foundation
import FoundationComponents

public protocol CurrencySymbolProtocol {
    var symbol: String { get }
}

public struct CurrencyEditListData {
    public let sections: [CurrencyEditListSection]

    public init() {
        sections = []
    }

    public init(currencySymbols: [CurrencySymbolProtocol]) {
        let items = currencySymbols.map { symbol in
            return CurrencyEditListItem(name: symbol.symbol)
        }

        let section = CurrencyEditListSection(items: items)

        sections = [section]
    }

    public var sectionCount: Int {
        return sections.count
    }

    public func itemCount(inSection section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }

    public func itemAt(indexPath: IndexPath) -> CurrencyEditListItem? {
        return sections[safe: indexPath.section]?.items[indexPath.row]
    }
}

public struct CurrencyEditListSection {
    public let items: [CurrencyEditListItem]
}

public struct CurrencyEditListItem {
    let name: String
}
