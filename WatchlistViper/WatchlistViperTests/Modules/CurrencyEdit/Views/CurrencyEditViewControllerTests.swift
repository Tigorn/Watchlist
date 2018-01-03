import Nimble
import Quick
import UIComponents
@testable import WatchlistViper

// swiftlint:disable force_cast
class CurrencyEditViewControllerTests: QuickSpec {
    override func spec() {
        describe("CurrencyEditViewController") {
            var viewController: CurrencyEditViewController!

            beforeEach {
                viewController = UIStoryboard.edit.instantiateViewController(withIdentifier: .currencyEditViewController) as! CurrencyEditViewController
                _ = viewController.view
            }

            it("gets currencies on viewDidAppear") {
                let presenter = MockPresenter()
                viewController.listener = presenter
                viewController.viewDidLoad()
                expect(presenter.didGetCurrencies).to(beTrue())
            }

            it("set currencies updates tableView") {
                let dataSource = MockDataSource()
                let tableView = MockTableView()
                viewController.dataSource = dataSource
                viewController.tableView = tableView
                viewController.set(data: CurrencyEditListData())
                expect(dataSource.didSetCurrencySymbols).to(beTrue())
                expect(tableView.didReloadData).to(beTrue())
            }
        }
    }
}

private class MockDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, CurrencyEditDataSourceInputProtocol {
    var didSetCurrencySymbols = false
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 1
    }

    func tableView(_: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func set(data _: CurrencyEditListData) {
        didSetCurrencySymbols = true
    }
}

private class MockTableView: UITableView {
    var didReloadData = false

    override func reloadData() {
        didReloadData = true
    }
}

private class MockPresenter: CurrencyEditViewOutputProtocol {
    var view: CurrencyEditViewInputProtocol?
    var interactor: CurrencyEditInteractorInputProtocol?
    var didGetCurrencies = false

    func getCurrencies() {
        didGetCurrencies = true
    }

    func didGet(currencies _: [String]) {}
}
