import Quick
import Nimble
import LocalService
@testable import WatchlistViper

class AppDelegateTests: QuickSpec {
    override func spec() {
        describe("AppDelegate") {
            it("sets the rootViewController") {
                expect(UIApplication.shared.keyWindow?.rootViewController).toEventuallyNot(beNil())
            }
        }
    }
}

fileprivate class MockLocalPersistenceService: LocalPersistenceServiceProtocol {
    var didInitialize = false
    func initialize(completion: @escaping () -> ()) {
        didInitialize = true
    }

    func getCurrencySymbols(completion: @escaping ([String]) -> ()) { }

    func put(currencySymbol: String) { }
}
