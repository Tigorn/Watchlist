import Quick
import Nimble
import Domain
@testable import WatchlistViper

class CurrencyListDataSourceTests: QuickSpec {
    override func spec() {
        var dataSource: CurrencyListDataSource!
        var tableView: UITableView!

        beforeEach {
            tableView = UITableView()
            dataSource = CurrencyListDataSource()
            dataSource.set(currencies: [Currency()])
        }

        describe("CurrencyListViewController") {
            it("sets number of rows") {
                let currencies = [Currency(), Currency()]
                dataSource.set(currencies: currencies)
                expect(dataSource.tableView(tableView, numberOfRowsInSection: 0)).to(equal(2))
            }

            it("configures the cell") {
                let nib = UINib(nibName: .currencyListCell, bundle: Bundle.viper)
                tableView.register(nib, forCellReuseIdentifier: .currencyListCell)
                let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                expect(cell).to(beAKindOf(CurrencyListTableViewCell.self))
            }
        }
    }
}
