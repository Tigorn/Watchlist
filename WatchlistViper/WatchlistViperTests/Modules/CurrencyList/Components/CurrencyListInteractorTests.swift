import Quick
import Nimble
import Domain
import LocalService
@testable import WatchlistViper

class CurrencyListInteractorTests: QuickSpec {
    override func spec() {
        var interactor: CurrencyListInteractor!

        beforeEach {
            interactor = CurrencyListInteractor()
        }

        describe("CurrencyListInteractor") {
            it("delegates didGetCurrencies to the presenter") {
                let presenter = MockCurrencyListPresenter()
                interactor.presenter = presenter
                interactor.didGet(currencies: [])
                expect(presenter.didGetCurrencies).to(beTrue())
            }

            it("gets currency symbols from local") {
                let localDataManager = MockLocalDataManager()
                interactor.localInputDataManager = localDataManager
                interactor.getCurrencies()
                expect(localDataManager.didGetCurrencySymbols).to(beTrue())
            }

            it("gets remote tickers for local currency symbols") {
                let remoteDataManager = MockRemoteDataManager()
                interactor.remoteInputDataManager = remoteDataManager
                interactor.didGet(currencySymbols: [])
                expect(remoteDataManager.didGetCurrencyListTickers).to(beTrue())
            }

            it("delegates getCurrenciesDidFail to presenter") {
                let presenter = MockCurrencyListPresenter()
                interactor.presenter = presenter
                interactor.getCurrenciesDidFail()
                expect(presenter.getCurrenciesFailed).to(beTrue())
            }
        }
    }
}

fileprivate class MockRemoteDataManager: CurrencyListRemoteDataManagerInputProtocol {
    var outputEventHandler: CurrencyListRemoteDataManagerOutputProtocol?
    var didGetCurrencyListTickers = false

    func getCurrencyList(forCurrencySymbols symbols: [String]) {
        didGetCurrencyListTickers = true
    }
}

fileprivate class MockLocalDataManager: CurrencyListLocalDataManagerInputProtocol {
    var outputEventHandler: CurrencyListLocalDataManagerOutputProtocol?
    var didGetCurrencySymbols = false

    func getCurrencies() {
        didGetCurrencySymbols = true
    }
}

fileprivate class MockCurrencyListPresenter: CurrencyListInteractorOutputProtocol {
    var didGetCurrencies = false
    var getCurrenciesFailed = false

    func didGet(currencies: [Currency]) {
        didGetCurrencies = true
    }

    func getCurrenciesDidFail() {
        getCurrenciesFailed = true
    }
}
