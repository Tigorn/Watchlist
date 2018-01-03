import Domain
import Foundation
import FoundationComponents

struct CurrencyEditListData {
    let sections: [CurrencyEditListSection]

    init() {
        sections = []
    }

    init(currencySymbols: [CurrencySymbol]) {
        let items = currencySymbols.map { symbol in
            return CurrencyEditListItem(name: symbol.symbol)
        }

        let section = CurrencyEditListSection(items: items)

        sections = [section]
    }

    var sectionCount: Int {
        return sections.count
    }

    func itemCount(inSection section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }

    func itemAt(indexPath: IndexPath) -> CurrencyEditListItem? {
        return sections[safe: indexPath.section]?.items[indexPath.row]
    }
}

struct CurrencyEditListSection {
    let items: [CurrencyEditListItem]
}

struct CurrencyEditListItem {
    let name: String
}
