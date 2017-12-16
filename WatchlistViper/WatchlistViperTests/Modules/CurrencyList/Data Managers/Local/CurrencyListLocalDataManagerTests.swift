import Quick
import Nimble
import Domain
@testable import WatchlistViper

class CurrencyListLocalDataManagerTests: QuickSpec {
    override func spec() {
        var localDataManager: CurrencyListLocalDataManager!

        beforeEach {
            localDataManager = CurrencyListLocalDataManager()
        }

        describe("CurrencyListLocalDataManager") {
            it("gets currencies") {
                let listener = MockListener()
                localDataManager.localService = MockLocalPersistenceService()
                localDataManager.listener = listener
                localDataManager.getCurrencies()
                expect(listener.didGetCurrencySymbols).to(beTrue())
            }
        }
    }
}

fileprivate class MockListener: CurrencyListLocalDataManagerOutputProtocol {
    var didGetCurrencySymbols = false
    func didGet(currencySymbols: [String]) {
        didGetCurrencySymbols = true
    }
}

fileprivate class MockLocalPersistenceService: LocalPersistenceServiceProtocol {
    func initialize(completion: @escaping () -> ()) { }

    func getCurrencySymbols(completion: @escaping ([String]) -> ()) {
        completion([])
    }

    func put(currencySymbol: String) { }
}
