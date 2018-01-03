import Quick
import Nimble
import Domain
@testable import WatchlistRIBs

class BootstrapInteractorTests: QuickSpec {
    override func spec() {
        var interactor: BootstrapInteractor!
        var localPersistenceService: MockLocalPersistenceService!
        var bootstrapListener: MockBootstrapListener!
        var localDefaultsService: MockLocalDefaultsService!

        beforeEach {
            localDefaultsService = MockLocalDefaultsService()
            bootstrapListener = MockBootstrapListener()
            localPersistenceService = MockLocalPersistenceService()
            interactor = BootstrapInteractor(presenter: BootstrapViewController(), localFileService: MockLocalFileService(), localDefaultsService: localDefaultsService, localPersistenceService: localPersistenceService)
            interactor.listener = bootstrapListener
        }

        describe("BootstrapInteractor") {
            it("initializes local persistence on didBecomeActive") {
                interactor.didBecomeActive()
                expect(localPersistenceService.didInitialize).to(beTrue())
            }

            it("sets default currencies if not previously set") {
                localDefaultsService.didSetDefaultCurrencies = false
                interactor.didBecomeActive()
                expect(localPersistenceService.didPutCurrencySymbol).to(beTrue())
                expect(localDefaultsService.didSetDefaultCurrencies).to(beTrue())
            }

            it("does not set default currencies if previously set") {
                localDefaultsService.didSetDefaultCurrencies = true
                expect(localPersistenceService.didPutCurrencySymbol).to(beFalse())
                expect(localDefaultsService.didSetDefaultCurrencies).to(beTrue())
            }

            it("delegates to listener when initialization finishes") {
                interactor.didBecomeActive()
                expect(bootstrapListener.isInitializationFinished).to(beTrue())
            }
        }
    }
}

private class MockBootstrapListener: BootstrapListener {
    var isInitializationFinished = false

    func didFinishInitialization() {
        isInitializationFinished = true
    }
}

private class MockLocalPersistenceService: LocalPersistenceServiceProtocol {
    var didInitialize = false
    var didPutCurrencySymbol = false

    func initialize(completion: @escaping () -> Void) {
        didInitialize = true
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

private class MockLocalFileService: LocalFileServiceProtocol {
    func defaultCurrencySymbols() -> [CurrencySymbol] {
        return [CurrencySymbol(symbol: "btc", index: 0)]
    }
}
