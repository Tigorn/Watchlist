import Nimble
import Quick
@testable import WatchlistViper

class CurrencyEditPresenterTests: QuickSpec {
    override func spec() {
        describe("CurrencyEditPresenter") {
            var presenter: CurrencyEditPresenter!

            beforeEach {
                presenter = CurrencyEditPresenter()
            }

            it("get currencies") {
                let interactor = MockInteractor()
                presenter.interactor = interactor
                presenter.getCurrencies()
                expect(interactor.didGetCurrencies).to(beTrue())
            }

            it("updates view on didGetCurrencies") {
                let view = MockView()
                presenter.view = view
                presenter.didGet(currencySymbols: [])
                expect(view.didSetCurrencies).toEventually(beTrue())
            }
        }
    }
}

fileprivate class MockView: CurrencyEditViewInputProtocol {
    var listener: CurrencyEditViewOutputProtocol?
    var didSetCurrencies = false

    func set(currencySymbols _: [String]) {
        didSetCurrencies = true
    }
}

fileprivate class MockInteractor: CurrencyEditInteractorInputProtocol {
    var presenter: CurrencyEditInteractorOutputProtocol?
    var localInputDataManager: CurrencyEditLocalDataManagerInputProtocol?
    var didGetCurrencies = false

    func getCurrencies() {
        didGetCurrencies = true
    }
}
