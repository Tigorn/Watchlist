import Quick
import Nimble
import LocalService
@testable import WatchlistViper

class CurrencyListLocalDataManagerTests: QuickSpec {
    override func spec() {
        var localDataManager: CurrencyListLocalDataManager!

        beforeEach {
            localDataManager = CurrencyListLocalDataManager()
        }

        describe("CurrencyListLocalDataManager") {
            it("gets currencies") {
                let eventHandler = MockOutputEventHandler()
                localDataManager.localPersistenceService = MockLocalPersistenceService()
                localDataManager.outputEventHandler = eventHandler
                localDataManager.getCurrencies()
                expect(eventHandler.didGetCurrencySymbols).to(beTrue())
            }
        }
    }
}

fileprivate class MockOutputEventHandler: CurrencyListLocalDataManagerOutputProtocol {
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
