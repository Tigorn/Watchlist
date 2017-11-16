import Quick
import Nimble
import Domain
@testable import RemoteService

class DataTaskComponentsTests: QuickSpec {
    override func spec() {
        describe("DataTaskComponents") {
            var dataTaskComponents: DataTaskComponents!

            beforeEach {
                let queryItem = URLQueryItem(name: "symbols", value: "tBTCUSD")
                dataTaskComponents = DataTaskComponents(route: Route.tickers, queryItems: [queryItem])
            }

            it("configures a URLRequest") {
                let urlRequest = dataTaskComponents.urlRequest
                expect(urlRequest?.url?.path).to(equal("/v2/tickers"))
                expect(urlRequest?.url?.host).to(equal("api.bitfinex.com"))
                expect(urlRequest?.url?.scheme).to(equal("https"))
                expect(urlRequest?.httpMethod).to(equal("GET"))
                expect(urlRequest?.url?.query).to(equal("symbols=tBTCUSD"))
            }
        }
    }
}
