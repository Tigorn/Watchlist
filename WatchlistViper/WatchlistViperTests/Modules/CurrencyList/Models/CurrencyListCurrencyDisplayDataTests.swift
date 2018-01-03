import Domain
import Nimble
import Quick
import UIComponents
@testable import WatchlistViper

class CurrencyListCurrencyDisplayDataTests: QuickSpec {
    override func spec() {
        describe("CurrencyListCurrencyDisplayData") {
            it("initializes from a Currency") {
                let data = CurrencyListCurrencyDisplayData(currencies: [Currency(), Currency()])
                expect(data.sections.first?.items.count).to(equal(2))
            }
        }
    }
}
