import Domain
import Nimble
import Quick
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
                localDataManager.listener = eventHandler
                localDataManager.localService = MockLocalPersistenceService()
                localDataManager.getCurrencies()
                expect(eventHandler.didGetCurrencies).toEventually(beTrue())
            }
        }
    }
}

fileprivate class MockLocalPersistenceService: LocalPersistenceServiceProtocol {
    func initialize(completion _: @escaping () -> Void) {}

    func getCurrencySymbols(completion: @escaping ([String]) -> Void) {
        completion([])
    }

    func put(currencySymbol _: String) {}
}

fileprivate class MockEventHandler: CurrencyEditLocalDataManagerOutputProtocol {
    var didGetCurrencies = false
    func didGet(currencySymbols _: [String]) {
        didGetCurrencies = true
    }
}
