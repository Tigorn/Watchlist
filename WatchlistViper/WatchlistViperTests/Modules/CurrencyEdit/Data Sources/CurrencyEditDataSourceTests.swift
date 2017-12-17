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
                dataSource.set(data: CurrencyEditListData())
                expect(dataSource.tableView(UITableView(), numberOfRowsInSection: 0)).to(equal(0))
            }

            it("configures cells") {
                dataSource.set(data: CurrencyEditListData())
                let tableView = UITableView()
                let nib = UINib(nibName: .currencyEditCell, bundle: Bundle.viper)
                tableView.register(nib, forCellReuseIdentifier: .currencyEditCell)
                let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                expect(cell).to(beAKindOf(CurrencyEditTableViewCell.self))
            }
        }
    }
}
