import Quick
import Nimble
import Domain
@testable import WatchlistViper

class CurrencyListViewControllerTests: QuickSpec {
    override func spec() {
        var viewController: CurrencyListViewController!

        beforeEach {
            viewController = UIStoryboard.list.instantiateViewController(withIdentifier: .currencyListViewController) as! CurrencyListViewController
            _ = viewController.view
        }

        describe("CurrencyListViewController") {
            it("sets currencies on show") {
                let tableView = UITableView()
                viewController.tableView = tableView
                let dataSource = CurrencyListDataSource()
                viewController.dataSource = dataSource
                viewController.show(currencies: [Currency(), Currency()])
                expect(dataSource.tableView(UITableView(), numberOfRowsInSection: 0)).toEventually(equal(2))
            }

            it("reloads data on show") {
                let tableView = MockTableView()
                viewController.tableView = tableView
                viewController.show(currencies: [])
                expect(tableView.didReloadData).toEventually(beTrue())
            }

            it("gets currencies on viewDidAppear") {
                let presenter = MockPresenter()
                viewController.presenter = presenter
                viewController.viewDidAppear(false)
                expect(presenter.didGetCurrencies).to(beTrue())
            }

            it("gets currencies on refresh") {
                let presenter = MockPresenter()
                viewController.presenter = presenter
                viewController.refresh()
                expect(presenter.didGetCurrencies).to(beTrue())
            }

            it("presents edit on didEditAction") {
                let presenter = MockPresenter()
                viewController.presenter = presenter
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

fileprivate class MockPresenter: CurrencyListPresenterProtocol {
    var view: CurrencyListViewProtocol?
    var interactor: CurrencyListInteractorInputProtocol?
    var router: CurrencyListRouterProtocol?
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
