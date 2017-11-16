import Quick
import Nimble
import Domain
@testable import RemoteService

class WebServiceTests: QuickSpec {
    override func spec() {
        describe("WebService") {
            var webService: WebService!
            var session: MockSession!

            beforeEach {
                session = MockSession(configuration: .default)
                webService = WebService()
            }

            it("returns a remote resource on completion") {
                let data = Data(base64Encoded: "test")
                session.data = data
                webService.session = session
                let dataTaskComponents = DataTaskComponents(route: Route.tickers)
                var result = false
                _ = webService.dataTask(dataTaskComponents: dataTaskComponents, completion: { remoteResource in
                    if remoteResource.data == data {
                        result = true
                    }
                })
                expect(result).toEventually(beTrue())
            }
        }
    }
}

fileprivate class MockSession: URLSessionProtocol {
    var data: Data? = nil
    var response: URLResponse? = nil
    var error: Error? = nil

    required init(configuration: URLSessionConfiguration) { }

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return URLSessionDataTask()
    }
}
