import Quick
import Nimble
import Domain
@testable import WatchlistViper

class CurrencyListViewControllerTests: QuickSpec {
    override func spec() {
        var viewController: CurrencyListViewController!
        var presenter: MockPresenter!
        var tableView: MockTableView!
        var dataSource: CurrencyListDataSource!

        beforeEach {
            viewController = UIStoryboard.list.instantiateViewController(withIdentifier: .currencyListViewController) as! CurrencyListViewController

            dataSource = CurrencyListDataSource()
            presenter = MockPresenter()
            tableView = MockTableView()

            viewController.dataSource = dataSource
            viewController.presenter = presenter
            _ = viewController.view
            viewController.tableView = tableView
        }

        describe("CurrencyListViewController") {
            it("sets currencies on show") {
                viewController.show(currencies: [Currency(), Currency()])
                expect(dataSource.tableView(UITableView(), numberOfRowsInSection: 0)).toEventually(equal(2))
            }

            it("reloads data on show") {
                viewController.show(currencies: [])
                expect(tableView.didReloadData).toEventually(beTrue())
            }

            it("gets currencies on viewDidAppear") {
                viewController.viewDidAppear(false)
                expect(presenter.didGetCurrencies).to(beTrue())
            }

            it("gets currencies on refresh") {
                viewController.refresh()
                expect(presenter.didGetCurrencies).to(beTrue())
            }

            it("presents edit on didEditAction") {
                viewController.didEditAction(self)
                expect(presenter.didEditActiontriggered).to(beTrue())
            }

            it("stops refresh control on requestFailed") {
                let refreshControl = viewController.tableView.refreshControl
                refreshControl?.beginRefreshing()
                expect(refreshControl?.isRefreshing).to(beTrue())
                viewController.requestFailed()
                expect(refreshControl?.isRefreshing).to(beFalse())
            }
        }
    }
}

fileprivate class MockPresenter: CurrencyListPresenterInputProtocol {
    var didGetCurrencies = false
    var didEditActiontriggered = false

    func getCurrencies() {
        didGetCurrencies = true
    }

    func didEditAction() {
        didEditActiontriggered = true
    }
}

fileprivate class MockTableView: UITableView {
    var didReloadData = false
    override func reloadData() {
        didReloadData = true
    }
}
