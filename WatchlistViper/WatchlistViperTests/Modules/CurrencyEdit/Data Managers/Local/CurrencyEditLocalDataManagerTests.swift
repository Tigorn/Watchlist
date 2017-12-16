import Quick
import Nimble
import Domain
@testable import WatchlistViper

class CurrencyEditLocalDataManagerTests: QuickSpec {
    override func spec() {
        describe("CurrencyEditLocalDataManager") {
            var localDataManager: CurrencyEditLocalDataManager!

            beforeEach {
                localDataManager = CurrencyEditLocalDataManager()
            }

            it("gets currencies") {
                let eventHandler = MockEventHandler()
                localDataManager.outputEventHandler = eventHandler
                localDataManager.localPersistenceService = MockLocalPersistenceService()
                localDataManager.getCurrencies()
                expect(eventHandler.didGetCurrencies).toEventually(beTrue())
            }
        }
    }
}

fileprivate class MockLocalPersistenceService: LocalPersistenceServiceProtocol {
    func initialize(completion: @escaping () -> ()) { }

    func getCurrencySymbols(completion: @escaping ([String]) -> ()) {
        completion([])
    }

    func put(currencySymbol: String) { }
}

fileprivate class MockEventHandler: CurrencyEditLocalDataManagerOutputProtocol {
    var didGetCurrencies = false
    func didGet(currencySymbols: [String]) {
        didGetCurrencies = true
    }
}
