import Quick
import Nimble
@testable import Domain

class CurrencyTests: QuickSpec {
    override func spec() {
        describe("Currency") {
            it("decodes tickers JSON data") {
                let currency = try? JSONDecoder().decode([Currency].self, from: Fixtures.btcTicker).first!
                expect(currency).toNot(beNil())
                expect(currency?.symbol).to(equal("tBTCUSD"))
                expect(currency?.lastPrice).to(equal(7620))
                expect(currency?.high).to(equal(8040))
                expect(currency?.low).to(equal(7505))
                expect(currency?.volume).to(equal(86548.49395655))
                expect(currency?.priceChange).to(equal(-246))
                expect(currency?.percentChange).to(equal(-0.0313))
            }
        }
    }
}
