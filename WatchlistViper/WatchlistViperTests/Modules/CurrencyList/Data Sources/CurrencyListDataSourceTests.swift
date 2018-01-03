import Domain
import Nimble
import Quick
@testable import UIComponents
@testable import WatchlistViper

class CurrencyListDataSourceTests: QuickSpec {
    override func spec() {
        var dataSource: CurrencyListDataSource!
        var tableView: UITableView!

        beforeEach {
            tableView = UITableView()
            dataSource = CurrencyListDataSource()
            dataSource.set(data: CurrencyListCurrencyDisplayData())
        }

        describe("CurrencyListViewController") {
            it("sets number of rows") {
                dataSource.set(data: CurrencyListCurrencyDisplayData())
                expect(dataSource.tableView(tableView, numberOfRowsInSection: 0)).to(equal(0))
            }

            it("configures the cell") {
                let nib = UINib(nibName: .currencyListCell)
                tableView.register(nib, forCellReuseIdentifier: .currencyListCell)
                let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                expect(cell).to(beAKindOf(CurrencyListTableViewCell.self))
            }
        }
    }
}
