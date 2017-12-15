import Quick
import Nimble
import LocalService
@testable import WatchlistViper

class CurrencyEditDataSourceTests: QuickSpec {
    override func spec() {
        describe("CurrencyEditDataSource") {
            var dataSource: CurrencyEditDataSource!

            beforeEach {
                dataSource = CurrencyEditDataSource()
            }

            it("set currencies") {
                dataSource.set(currencySymbols: ["btc", "ltc"])
                expect(dataSource.tableView(UITableView(), numberOfRowsInSection: 0)).to(equal(2))
            }

            it("configures cells") {
                dataSource.set(currencySymbols: ["btc"])
                let tableView = UITableView()
                let nib = UINib(nibName: .currencyEditCell, bundle: Bundle.viper)
                tableView.register(nib, forCellReuseIdentifier: .currencyEditCell)
                let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                expect(cell).to(beAKindOf(CurrencyEditTableViewCell.self))
            }
        }
    }
}
