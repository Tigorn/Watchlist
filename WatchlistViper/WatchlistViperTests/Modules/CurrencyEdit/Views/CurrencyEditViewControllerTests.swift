import Quick
import Nimble
@testable import WatchlistViper

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
                viewController.set(currencySymbols: [])
                expect(dataSource.didSetCurrencySymbols).to(beTrue())
                expect(tableView.didReloadData).to(beTrue())
            }
        }
    }
}

fileprivate class MockDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, CurrencyEditDataSourceInputProtocol {
    var didSetCurrencySymbols = false
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func set(currencySymbols: [String]) {
        didSetCurrencySymbols = true
    }
}

fileprivate class MockTableView: UITableView {
    var didReloadData = false

    override func reloadData() {
        didReloadData = true
    }
}

fileprivate class MockPresenter: CurrencyEditViewOutputProtocol {
    var view: CurrencyEditViewInputProtocol?
    var interactor: CurrencyEditInteractorInputProtocol?
    var didGetCurrencies = false

    func getCurrencies() {
        didGetCurrencies = true
    }

    func didGet(currencies: [String]) { }
}
