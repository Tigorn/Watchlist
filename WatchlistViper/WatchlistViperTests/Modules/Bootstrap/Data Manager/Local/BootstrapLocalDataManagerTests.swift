import Domain
import Nimble
import Quick
@testable import WatchlistViper

class BootstrapLocalDataManagerTests: QuickSpec {
    override func spec() {
        describe("BootstrapLocalDataManager") {
            var dataManager: BootstrapLocalDataManager!
            var localDefaultsService: MockLocalDefaultsService!
            var localPersistenceService: MockLocalPersistenceService!
            var localFileService: MockLocalFileService!

            beforeEach {
                localDefaultsService = MockLocalDefaultsService()
                localFileService = MockLocalFileService()
                localPersistenceService = MockLocalPersistenceService()
                dataManager = BootstrapLocalDataManager()
                dataManager.localDefaultsService = localDefaultsService
                dataManager.localPersistenceService = localPersistenceService
                dataManager.localFileService = localFileService
            }

            it("initializes persistence service") {
                let handler = MockOutputHandler()
                dataManager.listener = handler
                dataManager.initialize()
                expect(handler._didInitialize).to(beTrue())
            }

            it("sets and gets didSetDefaultCurrencies") {
                expect(dataManager.getDidSetDefaultCurrencies()).to(beFalse())
                dataManager.setDidSetDefaultCurrencies(value: true)
                expect(dataManager.getDidSetDefaultCurrencies()).to(beTrue())
                dataManager.localDefaultsService = nil
                expect(dataManager.getDidSetDefaultCurrencies()).to(beFalse())
            }

            it("gets default currencies") {
                expect(dataManager.getDefaultCurrencies()).to(equal([CurrencySymbol(symbol: "btc", index: 0)]))
                dataManager.localFileService = nil
                expect(dataManager.getDefaultCurrencies()).to(equal([]))
            }

            it("puts currency symbol") {
                dataManager.put(currencySymbol: CurrencySymbol(symbol: "btc", index: 0))
                expect(localPersistenceService.didPutCurrencySymbol).to(beTrue())
            }
        }
    }
}

private class MockOutputHandler: BootstrapLocalDataManagerOutputProtocol {
    var _didInitialize = false
    func didInitialize() {
        _didInitialize = true
    }
}

private class MockLocalFileService: LocalFileServiceProtocol {
    func defaultCurrencySymbols() -> [CurrencySymbol] {
        return [CurrencySymbol(symbol: "btc", index: 0)]
    }
}

private class MockLocalPersistenceService: LocalPersistenceServiceProtocol {
    var didPutCurrencySymbol = false

    func initialize(completion: @escaping () -> Void) {
        completion()
    }

    func getSortedCurrencySymbols(completion: @escaping ([CurrencySymbol]) -> Void) {
        completion([])
    }

    func put(currencySymbol: CurrencySymbol) {
        didPutCurrencySymbol = true
    }
}

private class MockLocalDefaultsService: LocalDefaultsServiceProtocol {
    var didSetDefaultCurrencies = false
}
