import Nimble
import Quick
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
                let dataTaskComponents = DataTaskComponents(route: MockRoute())
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

private class MockRoute: Routable {
    var path = "/path"
    var host = "host.com"
}

private class MockSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    required init(configuration _: URLSessionConfiguration) {}

    func dataTask(with _: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return URLSessionDataTask()
    }
}
