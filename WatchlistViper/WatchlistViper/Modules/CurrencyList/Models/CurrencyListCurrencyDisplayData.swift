import Domain
import FoundationComponents

struct CurrencyListCurrencyDisplayData {
    let sections: [CurrencyListCurrencyDisplaySection]

    init() {
        sections = []
    }

    init(currencies: [Currency]) {
        let items = currencies.map { currency in
            return CurrencyListCurrencyDisplayItem(name: currency.symbol, lastPrice: currency.lastPrice)
        }

        let section = CurrencyListCurrencyDisplaySection(items: items)

        sections = [section]
    }

    var sectionCount: Int {
        return sections.count
    }

    func itemCount(inSection section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }

    func itemAt(indexPath: IndexPath) -> CurrencyListCurrencyDisplayItem? {
        return sections[safe: indexPath.section]?.items[indexPath.row]
    }
}

struct CurrencyListCurrencyDisplaySection {
    var items = [CurrencyListCurrencyDisplayItem]()
}

struct CurrencyListCurrencyDisplayItem {
    let name: String?
    let lastPrice: Double?
}
