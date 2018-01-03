import Domain
import Nimble
import Quick
import UIComponents
@testable import WatchlistViper

// swiftlint:disable force_cast
class CurrencyListViewControllerTests: QuickSpec {
    override func spec() {
        var viewController: CurrencyListViewController!
        var presenter: MockPresenter!
        var tableView: MockTableView!
        var dataSource: MockDataSource!

        beforeEach {
            viewController = UIStoryboard.list.instantiateViewController(withIdentifier: .currencyListViewController) as! CurrencyListViewController

            dataSource = MockDataSource()
            presenter = MockPresenter()
            tableView = MockTableView()

            viewController.dataSource = dataSource
            viewController.listener = presenter
            _ = viewController.view
            viewController.tableView = tableView
        }

        describe("CurrencyListViewController") {
            it("sets currencies on show") {
                viewController.show(data: CurrencyListCurrencyDisplayData())
                expect(dataSource.didSetCurrencies).to(beTrue())
            }

            it("reloads data on show") {
                viewController.show(data: CurrencyListCurrencyDisplayData())
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

            it("hides refreshing UI on requestFailed") {
                let refreshControl = viewController.tableView.refreshControl
                refreshControl?.beginRefreshing()
                viewController.activityIndicator.startAnimating()
                viewController.requestFailed()
                expect(refreshControl?.isRefreshing).to(beFalse())
                expect(viewController.activityIndicator.isAnimating).to(beFalse())
            }

            it("hides refreshing UI on show data") {
                viewController.show(data: CurrencyListCurrencyDisplayData())
                expect(viewController.tableView.refreshControl?.isRefreshing).to(beFalse())
                expect(viewController.activityIndicator.isAnimating).to(beFalse())
            }
        }
    }
}

private class MockDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, CurrencyListDataSourceInputProtocol {
    var didSetCurrencies = false
    func set(data _: CurrencyListCurrencyDisplayData) {
        didSetCurrencies = true
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 0
    }

    func tableView(_: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

private class MockPresenter: CurrencyListViewOutputProtocol {
    var didGetCurrencies = false
    var didEditActiontriggered = false

    func getCurrencies() {
        didGetCurrencies = true
    }

    func didEditAction() {
        didEditActiontriggered = true
    }
}

private class MockTableView: UITableView {
    var didReloadData = false
    override func reloadData() {
        didReloadData = true
    }
}
