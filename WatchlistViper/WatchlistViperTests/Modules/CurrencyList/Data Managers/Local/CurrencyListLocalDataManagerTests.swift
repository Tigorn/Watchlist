import Domain
import Nimble
import Quick
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
    func didGet(currencySymbols _: [String]) {
        didGetCurrencySymbols = true
    }
}

fileprivate class MockLocalPersistenceService: LocalPersistenceServiceProtocol {
    func initialize(completion _: @escaping () -> Void) {}

    func getCurrencySymbols(completion: @escaping ([String]) -> Void) {
        completion([])
    }

    func put(currencySymbol _: String) {}
}
