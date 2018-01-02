import Domain
import Nimble
import Quick
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

private class MockLocalPersistenceService: LocalPersistenceServiceProtocol {
    var didInitialize = false
    func initialize(completion _: @escaping () -> Void) {
        didInitialize = true
    }

    func getSortedCurrencySymbols(completion _: @escaping ([CurrencySymbol]) -> Void) {}

    func put(currencySymbol: CurrencySymbol) {}
}
