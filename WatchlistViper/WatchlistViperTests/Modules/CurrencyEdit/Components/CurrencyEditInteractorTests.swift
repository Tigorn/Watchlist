import Quick
import Nimble
@testable import WatchlistViper

class CurrencyEditInteractorTests: QuickSpec {
    override func spec() {
        describe("CurrencyEditInteractor") {
            var interactor: CurrencyEditInteractor!

            beforeEach {
                interactor = CurrencyEditInteractor()
            }

            it("get currencies") {
                let localDataManager = MockLocalDataManager()
                interactor.localDataManager = localDataManager
                interactor.getCurrencies()
                expect(localDataManager.didGetCurrencies).to(beTrue())
            }

            it("updates presenter on didGetCurrencies") {
                let presenter = MockPresenter()
                interactor.listener = presenter
                interactor.didGet(currencySymbols: [])
                expect(presenter.didGetCurrencies).to(beTrue())
            }
        }
    }
}

fileprivate class MockPresenter: CurrencyEditInteractorOutputProtocol {
    var didGetCurrencies = false

    func didGet(currencySymbols: [String]) {
        didGetCurrencies = true
    }
}

fileprivate class MockLocalDataManager: CurrencyEditLocalDataManagerInputProtocol {
    var outputEventHandler: CurrencyEditLocalDataManagerOutputProtocol?
    var didGetCurrencies = false

    func getCurrencies() {
        didGetCurrencies = true
    }
}
