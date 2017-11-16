import Quick
import Nimble
import Domain
@testable import WatchlistViper

class CurrencyListViewControllerTests: QuickSpec {
    override func spec() {
        var viewController: CurrencyListViewController!

        beforeEach {
            viewController = UIStoryboard.list.instantiateViewController(withIdentifier: .currencyListViewController) as! CurrencyListViewController
        }

        describe("CurrencyListViewController") {
            it("sets currencies on show") {
                let tableView = UITableView()
                viewController.tableView = tableView
                let dataSource = MockDataSource()
                viewController.dataSource = dataSource
                viewController.show(currencies: [])
                expect(dataSource.didSetCurrencies).toEventually(beTrue())
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
        }
    }
}

fileprivate class MockPresenter: CurrencyListPresenterProtocol {
    var view: CurrencyListViewProtocol?
    var interactor: CurrencyListInteractorInputProtocol?
    var router: CurrencyListRouterProtocol?
    var didGetCurrencies = false

    func getCurrencies() {
        didGetCurrencies = true
    }
}

fileprivate class MockTableView: UITableView {
    var didReloadData = false
    override func reloadData() {
        didReloadData = true
    }
}

fileprivate class MockDataSource: CurrencyListDataSource {
    var didSetCurrencies = false
    override func set(currencies: [Currency]) {
        didSetCurrencies = true
    }
}
