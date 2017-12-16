import Quick
import Nimble
@testable import RemoteService

class DataTaskComponentsTests: QuickSpec {
    override func spec() {
        describe("DataTaskComponents") {
            var dataTaskComponents: DataTaskComponents!

            beforeEach {
                let queryItem = URLQueryItem(name: "symbols", value: "USD")
                dataTaskComponents = DataTaskComponents(route: MockRoute(), queryItems: [queryItem], localeType: "en-US")
            }

            it("configures a URLRequest") {
                let urlRequest = dataTaskComponents.urlRequest
                expect(urlRequest?.url?.path).to(equal("/path"))
                expect(urlRequest?.url?.host).to(equal("host.com"))
                expect(urlRequest?.url?.scheme).to(equal("https"))
                expect(urlRequest?.httpMethod).to(equal("GET"))
                expect(urlRequest?.url?.query).to(equal("symbols=USD"))
                expect(urlRequest?.allHTTPHeaderFields?["Accept-Language"]).to(equal("en-US"))
            }
        }
    }
}

fileprivate class MockRoute: Routable {
    var path: String = "/path"
    var host: String = "host.com"
}

