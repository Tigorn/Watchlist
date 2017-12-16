import Quick
import Nimble
@testable import Domain

class RouteTests: QuickSpec {
    override func spec() {
        describe("Route") {
            context("digital currency") {
                var route: Route!

                beforeEach {
                    route = Route.tickers
                }

                it("has a path") {
                    expect(route.path).to(equal("/v2/tickers/"))
                }

                it("has a host") {
                    expect(route.host).to(equal("api.bitfinex.com"))
                }
            }
        }
    }
}
