import Quick
import Nimble
import Domain
@testable import RemoteService
@testable import WatchlistViper

class CurrencyListRemoteDataManagerTests: QuickSpec {
    override func spec() {
        var remoteDataManager: CurrencyListRemoteDataManager!

        beforeEach {
            remoteDataManager = CurrencyListRemoteDataManager()
        }

        describe("CurrencyListRemoteDataManager") {
            it("gets ticker list from remote service") {
                let outputEventHandler = MockOutputEventHandler()
                remoteDataManager.outputEventHandler = outputEventHandler
                let mockService = MockSecuritiesService()
                mockService.getTickersShouldSucceed = true
                remoteDataManager.remoteService = mockService
                remoteDataManager.getCurrencyList(forCurrencySymbols: [])
                expect(outputEventHandler.didGetTickers).to(beTrue())
            }

            it("outputs getCurrenciesDidFail on failure") {
                let outputEventHandler = MockOutputEventHandler()
                remoteDataManager.outputEventHandler = outputEventHandler
                let mockService = MockSecuritiesService()
                mockService.getTickersShouldSucceed = false
                remoteDataManager.remoteService = mockService
                remoteDataManager.getCurrencyList(forCurrencySymbols: [])
                expect(outputEventHandler.getCurrenciesFailed).to(beTrue())
            }
        }
    }
}

fileprivate class MockOutputEventHandler: CurrencyListRemoteDataManagerOutputProtocol {
    var getCurrenciesFailed = false
    var didGetTickers = false

    func didGet(currencies: [Currency]) {
        didGetTickers = true
    }

    func getCurrenciesDidFail() {
        getCurrenciesFailed = true
    }
}

fileprivate class MockSecuritiesService: SecuritiesServiceProtocol {
    var getTickersShouldSucceed = true
    func getTickers<Type>(forCurrencySymbols symbols: [String], observers: [Type]) -> Command where Type : ServiceObserverProtocol, Type.Object == [Currency] {
        return Command {
            if self.getTickersShouldSucceed {
                observers.forEach { $0.didSucceed(value: [Currency()]) }
            } else {
                observers.forEach { $0.didFail(errors: []) }
            }
        }
    }
}
