import Quick
import Nimble
@testable import LocalService

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
                expect(result[0]).to(equal("tBTCUSD"))
                expect(result[1]).to(equal("tLTCUSD"))
                expect(result[2]).to(equal("tETHUSD"))
            }

            it("returns a empty list if there are no default currencies") {
                localService.bundle = Bundle.main
                let result = localService.defaultCurrencySymbols()
                expect(result.isEmpty).to(beTrue())
            }
        }
    }
}
