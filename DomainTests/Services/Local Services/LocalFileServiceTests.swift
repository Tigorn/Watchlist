@testable import Domain
import Nimble
import Quick

class LocalFileServiceTests: QuickSpec {
    override func spec() {
        describe("LocalFileService") {
            var localService: LocalFileService!

            beforeEach {
                localService = LocalFileService()
            }

            it("retrieves the default currencies") {
                let result = localService.defaultCurrencySymbols()
                expect(result.count).to(equal(3))
                expect(result[0]).to(equal(CurrencySymbol(symbol: "tBTCUSD", index: 0)))
                expect(result[1]).to(equal(CurrencySymbol(symbol: "tLTCUSD", index: 1)))
                expect(result[2]).to(equal(CurrencySymbol(symbol: "tETHUSD", index: 2)))
            }

            it("returns a empty list if there are no default currencies") {
                localService.bundle = Bundle.main
                let result = localService.defaultCurrencySymbols()
                expect(result.isEmpty).to(beTrue())
            }
        }
    }
}
