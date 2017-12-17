import Domain
import Nimble
import PromiseKit
import Quick
import RemoteService
@testable import WatchlistViper

class CurrencyListRemoteDataManagerTests: QuickSpec {
    override func spec() {
        var remoteDataManager: CurrencyListRemoteDataManager!
        var remoteService: MockSecuritiesService!
        var listener: MockListener!

        beforeEach {
            remoteDataManager = CurrencyListRemoteDataManager()
            listener = MockListener()
            remoteService = MockSecuritiesService()
            remoteDataManager.remoteService = remoteService
            remoteDataManager.listener = listener
        }

        describe("CurrencyListRemoteDataManager") {
            it("gets ticker list from remote service") {
                remoteService.getTickersShouldSucceed = true
                remoteDataManager.getCurrencyList(forCurrencySymbols: [])
                expect(listener.didGetTickers).toEventually(beTrue())
            }

            it("outputs getCurrenciesDidFail on failure") {
                remoteService.getTickersShouldSucceed = false
                remoteDataManager.getCurrencyList(forCurrencySymbols: [])
                expect(listener.getCurrenciesFailed).toEventually(beTrue())
            }
        }
    }
}

private class MockListener: CurrencyListRemoteDataManagerOutputProtocol {
    var getCurrenciesFailed = false
    var didGetTickers = false

    func didGet(currencies _: [Currency]) {
        didGetTickers = true
    }

    func getCurrenciesDidFail() {
        getCurrenciesFailed = true
    }
}

private class MockSecuritiesService: SecuritiesServiceProtocol {
    var getTickersShouldSucceed = true

    func getTickers(forCurrencySymbols _: [String]) -> Promise<[Currency]> {
        return Promise { fulfill, reject in
            if getTickersShouldSucceed {
                fulfill([Currency()])
            } else {
                reject(DataServiceError.cancelled)
            }
        }
    }
}
