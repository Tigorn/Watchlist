import Quick
import Nimble
@testable import WatchlistViper

class CurrencyEditRouterTests: QuickSpec {
    override func spec() {
        describe("CurrencyEditRouter") {
            it("returns a CurrencyEditRouter on create") {
                expect(CurrencyEditRouter.makeModule()).to(beAKindOf(CurrencyEditViewController.self))
            }
        }
    }
}
